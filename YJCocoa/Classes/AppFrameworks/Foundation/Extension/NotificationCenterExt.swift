//
//  NotificationCenterExt.swift
//  YJCocoa
//
//  Created by 阳君 on 2019/5/29.
//

import UIKit

private class YJNotificationObserver: NSObject {
    
    weak var observer: NSObject?
    var block: ((Notification) -> Void)!
    
    init(_ observer: NSObject, block: @escaping (Notification) -> Void) {
        super.init()
        self.observer = observer
        self.block = block
    }
    
    @objc func post(_ notification: Notification) {
        if self.observer == nil {
            NotificationCenter.default.removeObserver(self)
        } else {
            self.block(notification)
        }
    }
    
}

extension NotificationCenter {
    
    open func addObserver(_ observer: NSObject, name: NSNotification.Name, using block: @escaping (Notification) -> Void) {
        let array = self.notificatArray(name: name)
        for item in array {
            let notificatItem = item as! YJNotificationObserver
            if notificatItem.observer == nil {
                notificatItem.observer = observer
                notificatItem.block = block
            } else if observer == notificatItem.observer {
                notificatItem.block = block
                return
            }
        }
        let item = YJNotificationObserver(observer, block: block)
        array.add(item)
        self.addObserver(item, selector: #selector(YJNotificationObserver.post(_:)), name: name, object: nil)
    }
    
    open func removeObserverBlock(_ observer: NSObject, name: NSNotification.Name?) {
        if name == nil {
            for key in self.yj_notificatDict.allKeys {
                self.removeObserverBlock(observer, name: key as? NSNotification.Name)
            }
        } else {
            for item in self.notificatArray(name: name!) {
                let target = item as! YJNotificationObserver
                if observer == target.observer {
                    self.removeObserver(target)
                    return
                }
            }
        }
    }
    
    @objc private dynamic var yj_notificatDict: NSMutableDictionary {
        get {
            let key : UnsafeRawPointer! = UnsafeRawPointer.init(bitPattern: "yj_notificatDict".hashValue)
            guard let dict = objc_getAssociatedObject(self, key) as? NSMutableDictionary else {
                let dict = NSMutableDictionary()
                objc_setAssociatedObject(self, key, dict, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
                return dict
            }
            return dict
        }
        set {
            let key : UnsafeRawPointer! = UnsafeRawPointer.init(bitPattern: "yj_notificatDict".hashValue)
            objc_setAssociatedObject(self, key, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    
    private func notificatArray(name: NSNotification.Name) -> NSMutableArray {
        let dict = self.yj_notificatDict
        guard let array = dict[name] as? NSMutableArray else {
            let array = NSMutableArray()
            dict[name] = array
            return array
        }
        return array
    }
    
}
