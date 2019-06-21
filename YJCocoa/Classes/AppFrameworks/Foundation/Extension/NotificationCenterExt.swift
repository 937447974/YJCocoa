//
//  NotificationCenterExt.swift
//  YJCocoa
//
//  Created by 阳君 on 2019/5/29.
//

import UIKit

private class NotificationObserver {
    
    weak var observer: NSObject?
    var block: ((Notification) -> Void)!
    
    init(_ observer: NSObject, block: @escaping (Notification) -> Void) {
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
    
    /// Adds an entry to the notification center's dispatch table with an observer and a block, and an optional notification name.
    /// - parameter observer: Object registering as an observer.
    /// - parameter name: name The name of the notification for which to register the observer; that is, only notifications with this name are delivered to the observer.
    /// - parameter block: The block to be executed when the notification is received.
    open func addObserver(_ observer: NSObject, name: NSNotification.Name, using block: @escaping (Notification) -> Void) {
        let array = self.notificatArray(name: name)
        for item in array {
            let notificatItem = item as! NotificationObserver
            if notificatItem.observer == nil {
                notificatItem.observer = observer
                notificatItem.block = block
            } else if observer == notificatItem.observer {
                notificatItem.block = block
                return
            }
        }
        let item = NotificationObserver(observer, block: block)
        array.add(item)
        self.addObserver(item, selector: #selector(NotificationObserver.post(_:)), name: name, object: nil)
    }
    
    /// remove observer block
    open func removeObserverBlock(_ observer: NSObject, name: NSNotification.Name?) {
        if name == nil {
            for key in self.yj_notificatDict.allKeys {
                self.removeObserverBlock(observer, name: key as? NSNotification.Name)
            }
        } else {
            for item in self.notificatArray(name: name!) {
                let target = item as! NotificationObserver
                if observer == target.observer {
                    self.removeObserver(target)
                    return
                }
            }
        }
    }
    
    @objc
    private dynamic var yj_notificatDict: NSMutableDictionary {
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

@objcMembers
public class YJNotificationCenter: NSObject {
    
    public static func addObserver(_ observer: NSObject, name: NSNotification.Name, using block: @escaping (Notification) -> Void) {
        NotificationCenter.default.addObserver(observer, name: name, using: block)
    }
    
    /// remove observer block
    public static func removeObserverBlock(_ observer: NSObject, name: NSNotification.Name?) {
        NotificationCenter.default.removeObserverBlock(observer, name: name)
    }
    
}
