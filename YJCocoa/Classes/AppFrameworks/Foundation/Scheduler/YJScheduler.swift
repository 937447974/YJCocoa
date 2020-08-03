//
//  YJScheduler.swift
//  YJCocoa
//
//  HomePage:https://github.com/937447974/YJCocoa
//  YJ技术支持群:557445088
//
//  Created by 阳君 on 2019/5/30.
//  Copyright © 2016-现在 YJCocoa. All rights reserved.
//

import Foundation

/// 发布后执行方处理完毕的回调
public typealias YJSPublishHandler = (_ data: Any?) -> Void
/// 订阅回调
public typealias YJSSubscribeHandler = (_ data: Any?, _ publishHandler: YJSPublishHandler?) -> Void
/// 能否拦截
public typealias YJSInterceptCanHandler = (_ topic: String) -> Bool
/// 拦截回调
public typealias YJSInterceptHandler = (_ topic: String, _ data: Any?, _ publishHandler: YJSPublishHandler?) -> Void

/// 调度器单例
public let YJSchedulerS = YJScheduler()

/// 调度器
open class YJScheduler: NSObject {
    
    /// 调度器初始化启动加载
    public var loadScheduler: YJDispatchWork?
    
    private lazy var workQueue: YJDispatchQueue = {
        let queue = DispatchQueue(label: "com.yjcocoa.scheduler.work")
        return YJDispatchQueue(queue: queue, maxConcurrent: 1)
    }()
    private lazy var serialQueue: YJDispatchQueue = {
        let queue = DispatchQueue(label: "com.yjcocoa.scheduler.serial")
        return YJDispatchQueue(queue: queue, maxConcurrent: 1)
    }()
    private lazy var concurrentQueue: YJDispatchQueue = {
        let queue = DispatchQueue(label: "com.yjcocoa.scheduler.concurrent", attributes: DispatchQueue.Attributes.concurrent)
        return YJDispatchQueue(queue: queue, maxConcurrent: 8)
    }()
    
    private var isInitSub = false
    private var subDict = Dictionary<String, Array<YJSchedulerSubscribe>>()
    private var intArray = [YJSchedulerIntercept]()
    
}

extension YJScheduler {
    /// 调度队列
    public enum Queue: Int {
        /// 子队列
        case `default`
        /// 主队列
        case main
    }
}

// MARK: subscribe
extension YJScheduler {
    
    /**
     * 订阅
     * - Parameter topic:      主题
     * - Parameter subscriber: 订阅者，自动释放（传入nil代表永不释放）
     * - Parameter queue:      回调执行的队列, 默认子线程
     * - Parameter handler:    接受发布方传输的数据
     */
    public func subscribe(topic: String, subscriber: AnyObject? = nil, queue: YJScheduler.Queue = .default,  handler: @escaping YJSSubscribeHandler) {
        YJLogVerbose("[YJScheduler] \(String(describing: subscriber)) 订阅 \(topic)")
        let target = YJSchedulerSubscribe(topic: topic, subscriber: subscriber ?? self, queue: queue, completionHandler: handler)
        self.workQueue.async { [unowned self] in
            let subArray = self.subDict[topic] ?? []
            var newArray = [target]
            for item in subArray {
                guard let subscriber = target.subscriber else { return }
                if subscriber.isEqual(item.subscriber) && !subscriber.isEqual(self) {
                    continue
                } else if item.subscriber != nil {
                    newArray.append(item)
                } else {
                    YJLogVerbose("[YJScheduler] 自动取消订阅: \(item.topic)")
                }
            }
            self.subDict[topic] = newArray
        }
    }
    
    /**
     * 取消订阅
     * - Parameter topic:      主题
     * - Parameter subscriber: 订阅者
     * - Parameter queue:      回调执行的队列
     * - Parameter handler:    接受发布方传输的数据
     */
    public func removeSubscribe(topic: String? = nil, subscriber: AnyObject) {
        func removeSubscribe(topic: String, array: Array<YJSchedulerSubscribe>) {
            var newArray = Array<YJSchedulerSubscribe>()
            for item in array {
                if item.subscriber != nil && !subscriber.isEqual(item.subscriber) {
                    newArray.append(item)
                }
            }
            self.subDict[topic] = newArray
        }
        self.workQueue.async { [unowned self] in
            if let topic = topic {
                removeSubscribe(topic: topic, array: self.subDict[topic] ?? [])
            } else {
                for (topic, array) in self.subDict {
                    removeSubscribe(topic: topic, array: array)
                }
            }
        }
    }
    
}

// MARK: intercept
extension YJScheduler {
    
    /**
     *  拦截发布信息
     *  - Parameter interceptor 拦截者
     *  - Parameter canHandler  能否拦截
     *  - Parameter handler     拦截后执行的操作
     */
    public func intercept(interceptor: AnyObject?, canHandler: @escaping YJSInterceptCanHandler, completion handler: @escaping YJSInterceptHandler) {
        let item = YJSchedulerIntercept(interceptor: interceptor ?? self, canHandler: canHandler, completionHandler: handler)
        self.workQueue.async { [unowned self] in
            self.intArray.append(item)
        }
    }
}

// MARK: publish
extension YJScheduler {
    
    /**
     *  @abstract 能否发布
     *
     *  @param topic 主题
     *
     *  @return BOOL
     */
    @discardableResult
    public func canPublish(topic: String) -> Bool {
        self.initLoadScheduler()
        for item in self.intArray {
            if item.interceptor != nil && item.canHandler(topic) {
                return true
            }
        }
        let array = self.subDict[topic] ?? []
        for item in array {
            if item.subscriber != nil {
                return true
            }
        }
        return false
    }
    
    /**
     *  @abstract 发布信息
     *
     *  @param topic   主题
     *  @param data    携带的数据
     *  @param serial  yes串行发布no并行发布
     *  @param handler 接受方处理数据后的回调
     */
    public func publish(topic: String, data: Any? = nil, serial: Bool = false, completion handler: YJSPublishHandler? = nil) {
        self.initLoadScheduler()
        YJLogVerbose("[YJScheduler] 发布\(topic), data:\(data ?? "nil")")
       self.workQueue.async { [unowned self] in
            for item in self.intArray {
                if item.interceptor != nil && item.canHandler(topic) {
                    item.completionHandler(topic, data, handler)
                    return
                }
            }
            let subArray = self.subDict[topic] ?? []
            for item in subArray {
                guard let subscriber = item.subscriber else { continue }
                let block: YJDispatchWork = {
                    item.completionHandler(data, handler)
                }
                if item.queue == .main {
                    dispatch_async_main(block)
                } else {
                    let queue = serial ? self.serialQueue : self.concurrentQueue
                    queue.async(block)
                }
                _ = subscriber.hash
            }
        }
    }
    
    private func initLoadScheduler() {
        if self.isInitSub { return }
        self.isInitSub = true
        self.workQueue.sync {
            self.loadScheduler?()
        }
    }
    
}

// MARK: -
/// 调度器订阅
@objcMembers
private class YJSchedulerSubscribe : NSObject {
    let topic: String
    weak var subscriber: AnyObject?
    let queue: YJScheduler.Queue
    let completionHandler: YJSSubscribeHandler
    
    init(topic: String, subscriber: AnyObject, queue: YJScheduler.Queue, completionHandler: @escaping YJSSubscribeHandler) {
        self.topic = topic
        self.subscriber = subscriber
        self.queue = queue
        self.completionHandler = completionHandler
    }
    
}

/// 调度器拦截
private struct YJSchedulerIntercept {
    weak var interceptor: AnyObject?
    let canHandler: YJSInterceptCanHandler
    let completionHandler: YJSInterceptHandler
}
