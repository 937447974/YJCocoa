//
//  YJSingletonCenter.swift
//  Pods
//
//  Created by 阳君 on 2019/5/22.
//

import Foundation

/// 获取强引用单例
public func YJStrongSingleton(_ aClass: AnyClass, _ identifier: String? = nil) -> AnyObject {
    return YJSingletonCenter.shared.strongSingleton(aClass: aClass, forIdentifier: identifier)
}

/// 获取弱引用单例
public func YJWeakSingleton(_ aClass: AnyClass, _ identifier: String) -> AnyObject {
    return YJSingletonCenter.shared.weakSingleton(aClass: aClass, forIdentifier: identifier)
}

/** 单例中心*/
@objcMembers
open class YJSingletonCenter: NSObject & NSCacheDelegate {
    
    public static var shared = YJSingletonCenter()
    
    private let mutex = YJPthreadMutex()
    private var strongDict = YJSafetyDictionary()
    private var weakCache = YJSafetyCache<NSString, YJSingletonModel>()
    
    public override init() {
        super.init()
        self.weakCache.delegate = self
    }
    
    /// 强引用单例，一直存在
    public func strongSingleton(aClass: AnyClass, forIdentifier identifier: String? = nil) -> AnyObject {
        let identifier = identifier ?? NSStringFromClass(aClass) as String
        let model = self.mutex.lockObj {[unowned self] () -> AnyObject in
            guard let model = self.strongDict[identifier] else {
                let model = YJSingletonModel()
                self.strongDict[identifier] = model
                return model
            }
            return model as AnyObject
        }
        return (model as! YJSingletonModel).object(aClass: aClass, forIdentifier: identifier)
    }
    
    /// 弱引用单例，自动回收
    public func weakSingleton(aClass: AnyClass, forIdentifier identifier: String) -> AnyObject {
        let identifier1 = identifier as NSString
        let model = self.mutex.lockObj {[unowned self] () -> AnyObject in
            guard let model = self.weakCache.object(forKey: identifier1) else {
                let model = YJSingletonModel()
                self.weakCache.setObject(model, forKey: identifier1)
                return model
            }
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
