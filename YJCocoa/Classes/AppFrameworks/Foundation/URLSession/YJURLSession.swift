//
//  URLSession.swift
//  YJCocoa
//
//  Created by 阳君 on 2019/6/4.
//

import UIKit

typealias YJURLSessionTaskSuccess = (_ respModel: Any?) -> Void
typealias YJURLSessionTaskFailure = (_ error: NSError) -> Void

class YJURLSession: NSObject {
    
}

/// NSURLSessionTask
class YJURLSessionTask: NSObject {
    
    /// 网络请求状态
    enum State: Int {
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
    
    /// 任务状态
    var state = YJURLSessionTask.State.default
    var request: YJURLRequest!
    var handler = Array<(YJURLSessionTaskSuccess, YJURLSessionTaskFailure?)>()
    var mainQueue: Bool = false
    
    override init() {
        super.init()
    }
    
    class func task(with request: YJURLRequest) {
        
    }
    
    func mainQueue(_ mainQueue: Bool) -> YJURLSessionTask {
        return self
    }
    
    func completionHandler(success: YJURLSessionTaskSuccess, failure: YJURLSessionTaskFailure?) -> YJURLSessionTask {
        return self
    }
    
    /// 发送请求
    func resume() {
        
    }
    
    /// 暂停请求
    func suspend() {
        
    }
    
    /// 取消请求
    func cancel() {
        
    }
    
}


class YJURLRequest: NSObject {
    
    /// 网络请求方式
    enum Method: Int {
        /// POST请求   增
        case post
        /// DELETE请求 删
        case delete
        /// PUT请求    改
        case put
        /// GET请求    查
        case get
    }
    
    /// 唯一标示
    var identifier = ""
    /// 发起网络请求的对象
    weak var source: AnyObject?
    /// 请求地址
    var url = ""
    /// 请求方式
    var method: YJURLRequest.Method!
    /// 请求参数模型
    var reqModel: AnyObject?
    /// 服务器返回数据对应的模型class
    var respModelClass: AnyClass?
    
    init(source: AnyObject?, url: String, method: YJURLRequest.Method, reqModel: AnyObject? , respModelClass: AnyClass?) {
        super.init()
        self.source = source ?? YJURLRequest.self
        self.url = url
        self.method = method
        self.respModelClass = respModelClass
        self.identifier = "\(type(of: source))-\(url)-\(String(describing: reqModel))"
    }
    
}


