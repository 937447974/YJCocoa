//
//  YJLeaks.swift
//  YJCocoa
//
//  HomePage:https://github.com/937447974/YJCocoa
//  YJ技术支持群:557445088
//
//  Created by 阳君 on 2019/6/17.
//  Copyright © 2016-现在 YJCocoa. All rights reserved.
//

import UIKit

/// 内存泄漏器单例
public let YJLeaksS = YJLeaks()

/// 内存泄漏分析器
@objcMembers
public class YJLeaks: NSObject {
    
    struct Item {
        weak var obj: AnyObject?
        var path: String
        init(obj: AnyObject, path: String) {
            self.obj = obj
            self.path = path
        }
    }
    
    var ignoredClasses = Set<String>()
    
    /// 启动
    public static func start() {
        UINavigationController.yj_startCaptureMemoryLeaks()
        UIViewController.yj_startCaptureMemoryLeaks()
        UIView.yj_startCaptureMemoryLeaks()
    }
    
    public func captureMemoryLeaks(target: NSObject) {
        guard self.isValidation("\(type(of: target))") else {
            return
        }
        let className = "\(type(of: target))"
        YJLogVerbose("[YJLeaks] \(className) capture memory leaks");
        let leakPropertyArray = self.captureMemory(target: target, level: 0, path: className)
        dispatch_after_default(delayInSeconds: 3) { [weak target] in
            var array = [String]()
            for item in leakPropertyArray {
                if item.obj != nil {
                    array.append(item.path)
                }
            }
            var log: String = ""
            if target != nil {
                log += "\nClass : \(className)"
            }
            if array.count > 0 {
                log += "\nProperty : \(array)"
            }
            if log.count > 0 {
                YJLogDebug("[YJLeaks] 捕获内存泄漏" + log)
            }
        }
    }
    
    func captureMemory(target: NSObject, level: Int, path: String) -> Array<Item> {
        guard level < 3, self.isValidation("\(type(of: target))") else {
            return []
        }
        var result = Array<Item>()
        for p in self.leakProperties(targetClass: type(of: target)) {
            if let value = target.value(forKey: p) {
                if !self.isValidation("\(type(of: value))") {
                    continue
                }
                let item = Item(obj: value as AnyObject, path: path + "." + p)
                result.append(item)
                if let obj = value as? NSObject {
                    result.append(contentsOf: self.captureMemory(target: obj, level: level + 1, path: item.path))
                }
            }
        }
        return result
    }
    
    func isValidation(_ className: String) -> Bool {
        if self.ignoredClasses.contains(className) {
            return false
        }
        for prefix in ["Swift", "UI", "NS", "WK", "CA", "_"] {
            if className.hasPrefix(prefix) {
                return false
            }
        }
        return true
    }
    
    func leakProperties(targetClass: AnyClass) -> [String] {
        guard self.isValidation("\(targetClass)") else {
            return []
        }
        let dict = YJWeakSingleton(NSMutableDictionary.self, "NSObject(YJLeaks)")
        let className = "\(targetClass)" as NSString
        if let propertyArray = dict.object(forKey: className) as? [String] {
            return propertyArray
        }
        var result = [String]()
        var count: UInt32 = 0
        guard let properties = class_copyPropertyList(targetClass, &count) else {
            return result
        }
        for i in 0..<numericCast(count) {
            let property = properties[i]
            if let attributes = property_getAttributes(property), let propertyAttributes = String(utf8String: attributes), propertyAttributes.hasPrefix("T@"),
                propertyAttributes.contains(",&,") {
                result.append(String(cString: property_getName(property)))
            }
        }
        free(properties)
        if let superclass = targetClass.superclass() {
            result.append(contentsOf: self.leakProperties(targetClass: superclass))
        }
        dict.setObject(result, forKey: className)
        YJLogVerbose("解析：\(className): \(result)")
        return result
    }
    
}

fileprivate extension NSObject {
    
    @objc
    class func yj_startCaptureMemoryLeaks() {
        self.doesNotRecognizeSelector(#function)
    }
    
    func yj_captureMemoryLeaks() {
        YJLeaksS.captureMemoryLeaks(target: self)
    }
    
}

fileprivate extension UINavigationController {
    
    @objc
    override class func yj_startCaptureMemoryLeaks() {
        self.swizzling(originalSEL: #selector(UINavigationController.popViewController(animated:)), swizzlingSEL: #selector(UINavigationController.yj_popViewController(animated:)))
        self.swizzling(originalSEL: #selector(UINavigationController.popToViewController(_:animated:)), swizzlingSEL: #selector(UINavigationController.yj_popToViewController(_:animated:)))
        self.swizzling(originalSEL: #selector(UINavigationController.popToRootViewController(animated:)), swizzlingSEL: #selector(UINavigationController.yj_popToRootViewController(animated:)))
    }
    
    @objc
    func yj_popViewController(animated: Bool) -> UIViewController? {
        guard let vc = self.yj_popViewController(animated: animated) else {
            return nil
        }
        vc.yj_captureMemoryLeaks()
        return vc
    }
    
    @objc
    func yj_popToViewController(_ viewController: UIViewController, animated: Bool) -> [UIViewController]? {
        guard let array = self.yj_popToViewController(viewController, animated: animated) else {
            return nil
        }
        for vc in array {
            vc.yj_captureMemoryLeaks()
        }
        return array
    }
    
    @objc
    func yj_popToRootViewController(animated: Bool) -> [UIViewController]? {
        guard let array = self.yj_popToRootViewController(animated: animated) else {
            return nil
        }
        for vc in array {
            vc.yj_captureMemoryLeaks()
        }
        return array
    }
    
}

fileprivate extension UIViewController {
    
    @objc
    override class func yj_startCaptureMemoryLeaks() {
        self.swizzling(originalSEL: #selector(UIViewController.dismiss(animated:completion:)), swizzlingSEL: #selector(UIViewController.yj_dismiss(animated:completion:)))
    }
    
    @objc
    func yj_dismiss(animated flag: Bool, completion: (() -> Void)? = nil) {
        self.yj_captureMemoryLeaks()
        self.yj_dismiss(animated: flag, completion: completion)
    }
    
}

fileprivate extension UIView {
    
    @objc
    override class func yj_startCaptureMemoryLeaks() {
        self.swizzling(originalSEL: #selector(UIView.removeFromSuperview), swizzlingSEL: #selector(UIView.yj_removeFromSuperview))
    }
    
    @objc
    func yj_removeFromSuperview() {
        self.yj_captureMemoryLeaks()
        self.yj_removeFromSuperview()
    }
    
}


