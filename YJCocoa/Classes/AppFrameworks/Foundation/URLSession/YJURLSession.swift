//
//  URLSession.swift
//  YJCocoa
//
//  Created by 阳君 on 2019/6/4.
//

import UIKit

public typealias YJURLSessionTaskSuccess = (_ respModel: Any) -> Void
public typealias YJURLSessionTaskFailure = (_ error: NSError) -> Void

/// URLSession
open class YJURLSession: NSObject & NSCacheDelegate {
    
    /// 共享单例
    @objc
    public static let shared = YJURLSession()
    /// 共享网络会话池
    public lazy var cache: YJSafetyCache<NSString, YJURLSessionTask> = {
        let cache = YJSafetyCache<NSString, YJURLSessionTask>()
        cache.delegate = self
        return cache
    }()
    
    // MARK: NSCacheDelegate
    public func cache(_ cache: NSCache<AnyObject, AnyObject>, willEvictObject obj: YJURLSessionTask) {
        if obj.state == .default || obj.state == .running {
            dispatch_after_default(delayInSeconds: 0.2) {
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
    /// 失败回调
    public private(set) var success: YJURLSessionTaskSuccess!
    /// 成功回调
    public private(set) var failure: YJURLSessionTaskFailure!
    
    private var mainQueue: Bool = false
    private var handler = Array<(YJURLSessionTaskSuccess, YJURLSessionTaskFailure?)>()
    
    open class func task(with request: YJURLRequest) -> YJURLSessionTask {
        let cache = YJURLSession.shared.cache
        let key = request.identifier as NSString
        var task = cache.object(forKey: key)
        if task == nil {
            task = self.init()
            cache.setObject(task!, forKey: key)
        }
        task?.request = request
        return task!
    }
    
    public required override init() {
        super.init()
        self.success = { [unowned self] (data) in
            YJLogVerbose("[YJURLSession] \(self.request.identifier) 网络请求成功: \(data)")
            let block: YJDispatchBlock = { [unowned self] in
                self.state = .success
                let respModel = self.responseModel(with: data)
                for (success, _) in self.handler {
                    success(respModel)
                }
            }
            self.mainQueue ? dispatch_async_main(block: block) : block()
        }
        self.failure = { [unowned self] (error) in
            YJLogVerbose("[YJURLSession] \(self.request.identifier) 网络请求失败: \(error)")
            let block: YJDispatchBlock = { [unowned self] in
                self.state = .failure
                for (_, failure) in self.handler {
                    if failure != nil {
                        failure!(error)
                    }
                }
            }
            self.mainQueue ? dispatch_async_main(block: block) : block()
        }
    }
    
    open func mainQueue(_ mainQueue: Bool) -> YJURLSessionTask {
        return self
    }
    
    open func completionHandler(success: @escaping YJURLSessionTaskSuccess, failure: YJURLSessionTaskFailure?) -> YJURLSessionTask {
        self.handler.append((success, failure))
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
    public private(set) var url = ""
    /// 请求方式
    public private(set) var method = YJURLRequestMethod.post
    /// 请求参数模型
    public var reqModel: Any?
    /// 服务器返回数据对应的模型
    public var respModel: Any?
    
    public init(source: AnyObject?, url: String, method: YJURLRequestMethod, reqModel: Any? , respModel: Any? = nil) {
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


