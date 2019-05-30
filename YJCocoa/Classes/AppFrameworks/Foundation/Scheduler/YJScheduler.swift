//
//  YJScheduler.swift
//  YJCocoa
//
//  Created by 阳君 on 2019/5/30.
//

import UIKit

/// 发布后执行方处理完毕的回调
public typealias YJSPublishHandler = (_ data: Any?) -> Void
/// 订阅回调
public typealias YJSSubscribeHandler = (_ data: Any?, _ publishHandler: YJSPublishHandler?) -> Void
/// 能否拦截
public typealias YJSInterceptCanHandler = (_ topic: String) -> Void
/// 拦截回调
public typealias YJSInterceptHandler = (_ topic: String, _ data: Any?, _ publishHandler: YJSPublishHandler?) -> Void

/// 调度器 单例
public func YJSchedulerS() -> YJScheduler {
    return YJScheduler()
}

/// 调度器
open class YJScheduler: NSObject {
    
    /// 调度队列
    public enum Queue: Int {
        /// 主队列
        case main
        /// 子队列
        case `default`
    }
    
    
}

// MARK: subscribe
extension YJScheduler {
    
    /**
     * 订阅
     * - Parameter topic:      主题
     * - Parameter subscriber: 订阅者，自动释放（传入nil代表永不释放）
     * - Parameter queue:      回调执行的队列
     * - Parameter handler:    接受发布方传输的数据
     */
    public func subscribe(topic: String, subscriber: AnyObject?, queue:YJScheduler.Queue,  handler: @escaping YJSSubscribeHandler) {
    }
    
    /**
     * 取消订阅
     * - Parameter topic:      主题
     * - Parameter subscriber: 订阅者
     * - Parameter queue:      回调执行的队列
     * - Parameter handler:    接受发布方传输的数据
     */
    public func removeSubscribe(topic: String, subscriber: AnyObject) {
        
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
    public func intercept(interceptor: AnyObject?, canHandler: YJSInterceptCanHandler, completion handler: @escaping YJSInterceptHandler) {
        
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
    public func canPublish(topic: String) -> Bool {
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
    public func publish(topic: String, data: Any?, serial:Bool, completion handler: YJSPublishHandler?) {
        
    }
}

// MARK: -
private class YJSchedulerIntercept: NSObject {
    
    weak var interceptor: AnyObject?
    var canHandler: YJSInterceptCanHandler?
    var completionHandler: YJSInterceptHandler?
    
    init(interceptor: AnyObject?, canHandler: YJSInterceptCanHandler?, completionHandler: YJSInterceptHandler?) {
        super.init()
        self.interceptor = interceptor
        self.canHandler = canHandler
        self.completionHandler = completionHandler
    }
    
}

/// 调度器拦截
private class YJSchedulerSubscribe: NSObject {
    
    var topic: String!
    weak var subscriber: AnyObject?
    var queue: YJScheduler.Queue!
    var completionHandler: YJSSubscribeHandler?
    
    init(topic: String, subscriber: AnyObject?, queue: YJScheduler.Queue, completionHandler: YJSSubscribeHandler?) {
        super.init()
        self.topic = topic
        self.subscriber = subscriber
        self.queue = queue
        self.completionHandler = completionHandler
    }
    
}
