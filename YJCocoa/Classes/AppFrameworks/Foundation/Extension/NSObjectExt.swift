//
//  NSObjectExt.swift
//  YJCocoa
//
//  HomePage:https://github.com/937447974/YJCocoa
//  YJ技术支持群:557445088
//
//  Created by 阳君 on 2019/5/29.
//  Copyright © 2016-现在 YJCocoa. All rights reserved.
//

import UIKit

/// KVO 回调
public typealias YJKVOBlock = (_ oldValue: Any?, _ newValue: Any?) -> Void

private var kvos = Array<KeyValueObserver>()

private class KeyValueObserver : NSObject  {
    
    weak var target: AnyObject?
    weak var observer: AnyObject?
    var keyPath: String!
    var block: YJKVOBlock!
    
    init(_ target: AnyObject, observer: AnyObject, keyPath: String, block: @escaping YJKVOBlock) {
        super.init()
        self.target = target
        self.observer = observer
        self.keyPath = keyPath
        self.block = block
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if self.observer != nil {
            self.block(change?[NSKeyValueChangeKey.oldKey], change?[NSKeyValueChangeKey.newKey])
        }
    }
    
    deinit {
        target?.removeObserver(self, forKeyPath: keyPath)
    }
    
}

//MARK: KVO
public extension NSObject {
    
    /// 添加 KVO 监听
    @objc
    func addObserver(_ observer: AnyObject, forKeyPath keyPath: String, using block: @escaping YJKVOBlock) {
        let kvoArray = self.kvoArray(keyPath: keyPath)
        for item in kvoArray {
            let kvoItem = item as! KeyValueObserver
            if observer.isEqual(kvoItem.observer) {
                kvoItem.block = block
                return
            }
        }
        let kvo = KeyValueObserver(self, observer: observer, keyPath: keyPath, block: block)
        kvoArray.add(kvo)
        self.addObserver(kvo, forKeyPath: keyPath, options: [.old, .new], context: nil)
    }
    
    /// 移除 KVO 监听
    @objc
    func removeObserverBlock(_ observer: NSObject, forKeyPath keyPath: String? = nil) {
        if keyPath == nil {
            for key in self.yj_kvoDictionary.allKeys {
                self.removeObserverBlock(observer, forKeyPath: key as? String)
            }
        } else {
            for item in self.kvoArray(keyPath: keyPath!) {
                let kvoItem = item as! KeyValueObserver
                if kvoItem.observer != nil, observer.isEqual(kvoItem.observer) {
                    self.removeObserver(kvoItem, forKeyPath: keyPath!)
                    kvoItem.observer = nil
                    return
                }
            }
        }
    }
    
    private dynamic var yj_kvoDictionary: NSMutableDictionary {
        get {
            let key : UnsafeRawPointer! = UnsafeRawPointer.init(bitPattern: "yj_kvoDictionary".hashValue)
            guard let kvoDict = objc_getAssociatedObject(self, key) as? NSMutableDictionary else {
                let kvoDict = NSMutableDictionary()
                objc_setAssociatedObject(self, key, kvoDict, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
                return kvoDict
            }
            return kvoDict
        }
        set {
            let key : UnsafeRawPointer! = UnsafeRawPointer.init(bitPattern: "yj_kvoDictionary".hashValue)
            objc_setAssociatedObject(self, key, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    
    private func kvoArray(keyPath: String) -> NSMutableArray {
        let kvoDict = self.yj_kvoDictionary
        guard let kvoArray = kvoDict[keyPath] as? NSMutableArray else {
            let kvoArray = NSMutableArray()
            kvoDict[keyPath] = kvoArray
            return kvoArray
        }
        return kvoArray
    }
    
}

let cacheYJSwizzling = NSMutableDictionary()

//MARK:  Swizzling
extension NSObject {
    
    /// 交换方法(Instance)
    /// - parameter originalSEL:  原始方法
    /// - parameter swizzlingSEL: 交换的方法
    public static func swizzling(originalSEL: Selector, swizzlingSEL: Selector) {
        let cache = cacheYJSwizzling
        let key = "\(self)-\(originalSEL)-\(swizzlingSEL)" as NSString
        guard cache.object(forKey: key) == nil else {
            return
        }
        cache.setObject("YJSwizzling", forKey: key)
        cache.removeObject(forKey: "\(self)-\(swizzlingSEL)-\(originalSEL)" as NSString)
        YJLogDebug("[YJCocoa] \(self) 交换方法(\(originalSEL) <-> \(swizzlingSEL)")
        let originalM = class_getInstanceMethod(self, originalSEL)!
        guard let swizzlingM = class_getInstanceMethod(self, swizzlingSEL) else {
            YJLogError("[YJCocoa] \(self) 不存在方法: \(swizzlingSEL)")
            return
        }
        if class_addMethod(self, originalSEL, method_getImplementation(swizzlingM), method_getTypeEncoding(swizzlingM)) {
            class_replaceMethod(self, swizzlingSEL, method_getImplementation(originalM), method_getTypeEncoding(originalM));
        } else {
            method_exchangeImplementations(originalM, swizzlingM);
        }
    }
    
}
