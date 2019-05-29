//
//  NSObjectExt.swift
//  YJCocoa
//
//  Created by 阳君 on 2019/5/29.
//

import UIKit

/// KVO 回调
public typealias YJKVOBlock = (_ oldValue: Any?, _ newValue: Any?) -> Void

private class YJKeyValueObserver : NSObject  {
    
    weak var observer: NSObject?
    var kvoBlock: YJKVOBlock!
    
    init(_ observer: NSObject, kvoBlock: @escaping YJKVOBlock) {
        super.init()
        self.observer = observer
        self.kvoBlock = kvoBlock
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if self.observer != nil {
            self.kvoBlock(change?[NSKeyValueChangeKey.oldKey], change?[NSKeyValueChangeKey.newKey])
        }
    }
    
}

public extension NSObject {
    
    /// 添加 KVO 监听
    func addObserver(_ observer: NSObject, forKeyPath keyPath: String, kvoBlock: @escaping YJKVOBlock) {
        let kvoArray = self.kvoArray(keyPath: keyPath)
        for item in kvoArray {
            let kvoItem = item as! YJKeyValueObserver
            if observer == kvoItem.observer {
                kvoItem.kvoBlock = kvoBlock
                return
            }
        }
        let kvo = YJKeyValueObserver(observer, kvoBlock: kvoBlock)
        kvoArray.add(kvo)
        self.addObserver(kvo, forKeyPath: keyPath, options: [.old, .new], context: nil)
    }
    
    /// 移除 KVO 监听
    func removeObserverBlock(_ observer: NSObject, forKeyPath keyPath: String?) {
        if keyPath == nil {
            for key in self.yj_kvoDictionary.allKeys {
                self.removeObserverBlock(observer, forKeyPath: key as? String)
            }
        } else {
            for item in self.kvoArray(keyPath: keyPath!) {
                let kvoItem = item as! YJKeyValueObserver
                if observer == kvoItem.observer {
                    self.removeObserver(observer, forKeyPath: keyPath!)
                    return
                }
            }
        }
    }
    
    @objc private dynamic var yj_kvoDictionary: NSMutableDictionary {
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
