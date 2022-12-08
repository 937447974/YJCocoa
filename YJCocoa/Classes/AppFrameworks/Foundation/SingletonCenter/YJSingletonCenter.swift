//
//  YJSingletonCenter.swift
//  YJCocoa
//
//  HomePage:https://github.com/937447974/YJCocoa
//  YJ技术支持群:557445088
//
//  Created by 阳君 on 2019/5/22.
//  Copyright © 2016-现在 YJCocoa. All rights reserved.
//

import Foundation

/// 获取强引用单例
public func YJStrongSingleton<Object: AnyObject>(_ aClass: Object.Type, _ identifier: String? = nil) -> Object {
    return YJSingletonCenterS.strongSingleton(aClass: aClass, forIdentifier: identifier) as! Object
}

/// 获取弱引用单例
public func YJWeakSingleton<Object: AnyObject>(_ aClass: Object.Type, _ identifier: String) -> Object {
    return YJSingletonCenterS.weakSingleton(aClass: aClass, forIdentifier: identifier) as! Object
}

/// 单例中心
public let YJSingletonCenterS = YJSingletonCenter()

/** 单例中心*/
@objcMembers
open class YJSingletonCenter: NSObject & NSCacheDelegate {
    
    /// 共享
    public static let share = YJSingletonCenterS
    
    private let mutex = YJPthreadMutex()
    private var strongDict = [String: YJSingletonModel]()
    private var weakCache = NSCache<NSString, YJSingletonModel>()
    
    public override init() {
        super.init()
        self.weakCache.delegate = self
    }
    
    /// 重置
    public func reset() {
        self.strongDict.removeAll()
        self.weakCache.removeAllObjects()
    }
    
    /// 强引用单例，一直存在
    public func strongSingleton(aClass: AnyObject.Type, forIdentifier identifier: String? = nil) -> AnyObject {
        let identifier = identifier ?? NSStringFromClass(aClass) as String
        let model = self.mutex.lockObj { [unowned self] () -> YJSingletonModel in
            if let cache = self.strongDict[identifier] {
                return cache
            }
            let model = YJSingletonModel()
            self.strongDict[identifier] = model
            return model
        }
        return model.object(aClass: aClass, forIdentifier: identifier)
    }
    
    /// 弱引用单例，自动回收
    public func weakSingleton(aClass: AnyClass, forIdentifier identifier: String) -> AnyObject {
        let model = self.mutex.lockObj {[unowned self] () -> AnyObject in
            let identifier = identifier as NSString
            if let cache = self.weakCache.object(forKey: identifier) {
                return cache
            }
            let model = YJSingletonModel()
            self.weakCache.setObject(model, forKey: identifier)
            return model
        }
        return (model as! YJSingletonModel).object(aClass: aClass, forIdentifier: identifier)
    }
    
    /// 移除弱引用单例
    func removeWeakSingleton(forIdentifier identifier: String) {
        self.mutex.lock { [unowned self] in
            self.weakCache.removeObject(forKey: identifier as NSString)
        }
    }
    
    // MARK: NSCacheDelegate
    public func cache(_ cache: NSCache<AnyObject, AnyObject>, willEvictObject obj: Any) {
        YJLogVerbose("[YJCocoa] 释放：\(obj)")
    }
    
}

class YJSingletonModel {
    
    private let mutex = YJPthreadMutex()
    var obj: AnyObject!
    
    func object(aClass: AnyClass, forIdentifier identifier: String) -> AnyObject {
        guard self.obj != nil else {
            return self.mutex.lockObj {[unowned self] () -> AnyObject in
                if self.obj != nil {
                    return self.obj
                } else if let viewType = aClass as? UIView.Type {
                    self.obj = viewType.init(frame: CGRect.zero)
                } else if let objType = aClass as? NSObject.Type  {
                    self.obj = objType.init()
                }
                return self.obj
            }
        }
        return self.obj
    }
    
}
