//
//  YJURLRouter.swift
//  YJCocoa
//
//  HomePage:https://github.com/937447974/YJCocoa
//  YJ技术支持群:557445088
//
//  Created by 阳君 on 2019/6/4.
//  Copyright © 2016-现在 YJCocoa. All rights reserved.
//

import UIKit

/// 路由回调
public typealias YJRCompletionHandler = (_ options: [String: Any]) -> Void
/// 未注册 url 能否打开
public typealias YJRUnregisteredCanOpen = (_ url: String) -> Bool
/// 能否打开路由
public typealias YJRCanOpenHandler = (_ can: Bool) -> Void
/// 打开路由
public typealias YJROpenHandler = (_ url: String, _ options: [String: Any], _ handler: YJRCompletionHandler?) -> Void

/// 路由协议
@objc
public protocol YJURLRouterProtocol {
    /// 获取路由缓存标识符
    static func routerCacheIdentifier(with url: String, options: [String: Any]) -> String
    /// 路由器初始化
    static func router(with url: String) -> UIViewController
    /// 路由器能否打开
    func routerCanOpen(with options:[String: Any], handler: @escaping YJRCanOpenHandler)
    /// 路由器打开
    func routerOpen()
    /// push失败后，present 打开当前路由
    func routerOpenPresent()
    /// 路由器刷新数据
    func routerReloadData(with options:[String: Any], completion handler: YJRCompletionHandler?)
}

/// 路由器单例
public var YJURLRouterS = YJURLRouter()

/// URL 路由器
open class YJURLRouter: NSObject {
    
    /// 路由器初始化启动加载
    public var loadRouter: YJDispatchWork?
    
    var nodeCache = NSCache<NSString, UIViewController>()
    var isInitRouter = false
    
    /**
     *  注册路由
     *  - parameter url:   路由链接
     *  - parameter cls:   UIViewController.Type
     *  - parameter cache: 是否缓存
     */
    public func register(url: String, cls: UIViewController.Type, cache: Bool = false) {
        self.registerRouter(register: YJRouterRegister(url: url, cls: cls, cache: cache))
    }
    
    /**
     *  注册路由
     *  - parameter url:     路由链接
     *  - parameter handler: block 自定义跳转
     */
    public func register(url: String, handler: @escaping YJROpenHandler) {
        self.registerRouter(register: YJRouterRegister(url: url, cls: nil, cache: false, handler: handler))
    }
    
    private func registerRouter(register: YJRouterRegister) {
        YJLogVerbose("[YJURLRouter] 注册:\(register.url)")
        let topic = self.topic(with: register.url)
        YJSchedulerS.subscribe(topic: topic, subscriber: self, queue: .main) { [unowned self] (data: Any?, handler: YJSPublishHandler?) in
            let options: [String: Any] = data as! [String: Any]
            self.openRouter(register: register, options: options, completion: handler)
        }
    }
    
    private func openRouter(register: YJRouterRegister, options: [String: Any], completion handler:YJRCompletionHandler?) {
        guard register.handler == nil else {
            register.handler!(register.url, options, handler)
            return
        }
        let key = register.cls!.routerCacheIdentifier(with: register.url, options: options) as NSString
        var node: UIViewController! = self.getCacheNode(with: register, key: key)
        if node == nil  {
            node = register.cls!.router(with: register.url)
            if register.cache {
                self.nodeCache.setObject(node, forKey: key)
            }
        }
        node.routerCanOpen(with: options) { [weak node] (can) in
            guard can else { return }
            node?.routerOpen()
            dispatch_async_main { [weak node] in
                node?.routerReloadData(with: options, completion: handler)
            }
        }
    }
    
    private func getCacheNode(with register: YJRouterRegister, key: NSString) -> UIViewController? {
        guard let cacheNode = self.nodeCache.object(forKey: key) else {
            return nil
        }
        guard let nc = cacheNode.navigationController else {
            return cacheNode
        }
        for vc in nc.viewControllers {
            if vc.isEqual(cacheNode) {
                return nil
            }
        }
        return cacheNode
    }
    
}

extension YJURLRouter {
    
    /**
     *  拦截未注册的路由
     *  - parameter canOpen:     能否打开路由
     *  - parameter openHandler: 打开路由
     */
    public func interceptUnregistered(canOpen: @escaping YJRUnregisteredCanOpen, openHandler: @escaping YJROpenHandler) {
        YJSchedulerS.intercept(interceptor: self, canHandler: { [unowned self] (topic: String) -> Bool in
            return canOpen(self.url(with: topic))
        }) { [unowned self] (topic: String, data: Any?, publishHandler: YJSPublishHandler?) in
            let url = self.url(with: topic)
            YJLogVerbose("[YJURLRouter] 拦截:\(url)")
            let options: [String: Any] = data as? [String: Any] ?? [:]
            openHandler(url, options, publishHandler);
        }
    }
    
}

extension YJURLRouter {
    
    /**
     *  能否打开路由
     *  - parameter url: 路由链接
     *  - Returns: BOOL
     */
    @discardableResult
    public func canOpen(url: String) -> Bool {
        self.initLoadScheduler()
        let url = self.urlPrefix(with: url)
        let topic = self.topic(with: url)
        return YJSchedulerS.canPublish(topic: topic)
    }
    
    /**
     * 打开路由
     * - parameter url:     路由链接
     * - parameter options: 参数
     * - parameter handler: 路由执行操作后的回调
     */
    public func openURL(url: String, options: [String: Any]? = nil, completion handler: YJRCompletionHandler? = nil) {
        self.initLoadScheduler()
        var options = options ?? [:]
        if url.contains("?") {
            let urlOptions = YJURL.analysisParams(url, decode: true)
            options.merge(urlOptions){ (current, _) in current }
        }
        YJLogVerbose("[YJURLRouter] 打开:\(url)，options:\(options)")
        let topic = self.topic(with: url)
        YJSchedulerS.publish(topic: topic, data: options, serial: true) { (data: Any?) in
            handler?(data as! [String: Any])
        }
    }
    
    func initLoadScheduler() {
        if self.isInitRouter { return }
        self.isInitRouter = true
        self.loadRouter?()
    }
    
    func topic(with url: String) -> String {
        // scheme:[//[user:password@]host[:port]][/]path[?query][#fragment]
        return "url:\(url)"
    }
    
    func url(with topic: String) -> String {
        return topic[4..<topic.count]
    }
    
    func urlPrefix(with url: String) -> String {
        guard url.count > 0 else {
            YJLogError("[YJURLRouter] 打开的 url 为空")
            return url
        }
        return String(url.split(separator: "?")[0])
    }
}

@objc
extension UIViewController: YJURLRouterProtocol {
    
    public static func routerCacheIdentifier(with url: String, options: [String: Any]) -> String {
        return url
    }
    
    public static func router(with url: String) -> UIViewController {
        let vc = self.init()
        vc.hidesBottomBarWhenPushed = true
        return vc
    }
    
    open func routerReloadData(with options: [String: Any], completion handler: YJRCompletionHandler?) {}
    
    open func routerCanOpen(with options:[String: Any], handler: @escaping YJRCanOpenHandler) {
        handler(true)
    }
    
    open func routerOpen() {
        guard let nc = UIViewController.current?.navigationController else {
            self.routerOpenPresent()
            return
        }
        nc.pushViewController(self, animated: true)
        if self.view.backgroundColor == nil {
            self.view.backgroundColor = UIColor.white
        }
    }
    
    open func routerOpenPresent() {
        UIViewController.current?.present(self, animated: true, completion: nil)
        if self.view.backgroundColor == nil {
            self.view.backgroundColor = UIColor.white
        }
    }
    
}

private class YJRouterRegister {
    
    /// 是否缓存
    var cache = false
    /// 地址
    var url = ""
    /// 节点YJNSURLRouterProtocol实现类
    var cls: UIViewController.Type?
    /// 节点 block 实现回调
    var handler: YJROpenHandler?
    
    init(url:String, cls: UIViewController.Type?, cache: Bool, handler: YJROpenHandler? = nil) {
        self.url = url
        self.cache = cache
        self.cls = cls
        self.handler = handler
    }
    
}

private class YJRouterUnregistered {
    
    var canOpen: YJRUnregisteredCanOpen!
    var openHandler: YJROpenHandler!
    
    init(canOpen: @escaping YJRUnregisteredCanOpen, openHandler: @escaping YJROpenHandler) {
        self.canOpen = canOpen
        self.openHandler = openHandler
    }
    
}
