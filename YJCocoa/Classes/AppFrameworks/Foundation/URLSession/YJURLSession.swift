//
//  URLSession.swift
//  YJCocoa
//
//  HomePage:https://github.com/937447974/YJCocoa
//  YJ技术支持群:557445088
//
//  Created by 阳君 on 2019/6/4.
//  Copyright © 2016-现在 YJCocoa. All rights reserved.
//

import UIKit

public typealias YJURLSessionTaskSuccess = (_ respModel: Any) -> Void
public typealias YJURLSessionTaskFailure = (_ error: Error) -> Void

/// URLSession 单例
public let YJURLSessionS = YJURLSession()

/// URLSession
open class YJURLSession: NSObject & NSCacheDelegate {
    
    /// 共享网络会话池
    public lazy var cache: YJSafetyCache<NSString, YJURLSessionTask> = {
        let cache = YJSafetyCache<NSString, YJURLSessionTask>()
        cache.delegate = self
        return cache
    }()
    
    // MARK: NSCacheDelegate
    public func cache(_ cache: NSCache<AnyObject, AnyObject>, willEvictObject obj: YJURLSessionTask) {
        if obj.state == .default || obj.state == .running {
            DispatchQueue.afterDefault(delayInSeconds: 0.2) {
                cache.setObject(obj, forKey: obj.request!.identifier as AnyObject)
            }
        }
    }
    
}

/// 网络请求状态
@objc public enum YJURLSessionTaskState: Int {
    /// 初始化状态
    case `default`
    /// 正在请求
    case running
    /// 暂停请求
    case suspended
    /// 取消请求
    case cancel
    /// 请求成功
    case success
    /// 请求失败
    case failure
}

/// NSURLSessionTask
@objcMembers
open class YJURLSessionTask: NSObject {
    
    /// 任务状态
    public var state = YJURLSessionTaskState.default
    /// YJURLRequest
    public var request: YJURLRequest!
    /// 成功回调
    public private(set) var success: YJURLSessionTaskSuccess!
    /// 失败回调
    public private(set) var failure: YJURLSessionTaskFailure!
    private var handler = [Handler]()
    
    open class func task(with request: YJURLRequest) -> Self {
        let cache = YJURLSessionS.cache
        let key = request.identifier as NSString
        var task = cache.object(forKey: key)
        if task == nil {
            task = self.init()
            cache.setObject(task!, forKey: key)
        }
        task?.request = request
        return task as! Self
    }
    
    public required override init() {
        super.init()
        self.success = { [unowned self] (data: Any) in
            guard self.state == .running else { return }
            YJLogVerbose("[YJURLSession] \(self.request.identifier) 网络请求成功: \(data)")
            let respModel = self.responseModel(with: data)
            self.state = .success
            let handler = self.handler
            self.handler.removeAll()
            for item in handler {
                if item.source != nil, let success = item.success {
                    item.mainQueue ? dispatch_async_main({success(respModel)}) : success(respModel)
                }
            }
        }
        self.failure = { [unowned self] (error) in
            guard self.state == .running else { return }
            YJLogVerbose("[YJURLSession] \(self.request.identifier) 网络请求失败: \(error)")
            self.state = .failure
            let handler = self.handler
            self.handler.removeAll()
            for item in handler {
                if item.source != nil, let failure = item.failure {
                    item.mainQueue ? dispatch_async_main({failure(error)}) : failure(error)
                }
            }
        }
    }
    
    open func mainQueue(_ mainQueue: Bool) -> YJURLSessionTask {
        return self
    }
    
    open func completionHandler(mainQueue: Bool = false, success: YJURLSessionTaskSuccess? = nil, failure: YJURLSessionTaskFailure? = nil) -> YJURLSessionTask {
        self.handler.append(Handler(source: self.request.source, mainQueue: mainQueue, success: success, failure: failure))
        return self
    }
    
    /// 发送请求
    open func resume() {
        YJLogVerbose("[YJURLSession] \(self.request.identifier) 发送网络请求")
        self.state = .running
    }
    
    /// 暂停请求
    open func suspend() {
        YJLogVerbose("[YJURLSession] \(self.request.identifier) 暂停网络请求")
        self.state = .suspended
    }
    
    /// 取消请求
    open func cancel() {
        YJLogVerbose("[YJURLSession] \(self.request.identifier) 取消网络请求")
        self.state = .cancel
    }
    
    open func responseModel(with data: Any) -> Any {
        guard let respModel = self.request.respModel else {
            return data
        }
        if let json = data as? String {
            return YJJSONModel.transformToModel(respModel, fromJSON: json)
        }
        if let dictionary = data as? [String: Any] {
            return YJJSONModel.transformToModel(respModel, fromDict: dictionary)
        }
        return data
    }
    
}

extension YJURLSessionTask {
    fileprivate class Handler: NSObject {
        weak var source: AnyObject?
        var mainQueue: Bool = false
        var success: YJURLSessionTaskSuccess?
        var failure: YJURLSessionTaskFailure?
        public init(source: AnyObject?, mainQueue: Bool, success: YJURLSessionTaskSuccess?, failure: YJURLSessionTaskFailure?) {
            super.init()
            self.source = source
            self.mainQueue = mainQueue
            self.success = success
            self.failure = failure
        }
    }
}

/// 网络请求方式
@objc
public enum YJURLRequestMethod: Int {
    /// POST请求   增
    case post
    /// DELETE请求 删
    case delete
    /// PUT请求    改
    case put
    /// GET请求    查
    case get
}

@objcMembers
open class YJURLRequest: NSObject {
    
    /// 唯一标示
    public var identifier = ""
    /// 发起网络请求的对象
    public private(set) weak var source: AnyObject?
    /// 请求地址
    public var url = ""
    /// 请求方式
    public var method = YJURLRequestMethod.post
    /// 请求头
    public var headers: [String: String]?
    /// 请求参数模型
    public var reqModel: Any?
    /// 服务器返回数据对应的模型
    public var respModel: Any?
    
    public init(source: AnyObject? = nil, url: String = "", method: YJURLRequestMethod = .get, reqModel: Any? = nil, respModel: Any? = nil) {
        super.init()
        self.identifier = url
        self.source = source ?? YJURLRequest.self
        self.url = url
        self.method = method
        self.reqModel = reqModel
        self.respModel = respModel
        if let rm = reqModel {
            self.identifier = url + "-\(rm)"
        }
    }
    
}


