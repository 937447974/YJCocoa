//
//  YJLeaks.swift
//  Pods
//
//  Created by 阳君 on 2019/6/17.
//

import UIKit

/// 内存泄漏分析器
public class YJLeaks: NSObject {
    
    struct Item {
        weak var obj: AnyObject?
        var path: String
        init(obj: AnyObject, path: String) {
            self.obj = obj
            self.path = path
        }
    }
    
    public static let shared = YJLeaks()
    var ignoredClasses = Set<String>()
    
    /// 启动
    public static func start() {
        UINavigationController.yj_startCaptureMemoryLeaks()
        UIViewController.yj_startCaptureMemoryLeaks()
        UIView.yj_startCaptureMemoryLeaks()
    }
    
    public func captureMemoryLeaks(target: AnyObject) {
        guard self.isValidation(target) else {
            return
        }
        let className = "\(type(of: target))"
        YJLogVerbose("[YJLeaks] \(className) capture memory leaks");
        let leakPropertyArray = self.captureMemory(target: target, level: 0, path: className)
        dispatch_after_default(delayInSeconds: 3, block: { [weak target] in
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
        })
    }
    
    func captureMemory(target: Any, level: Int, path: String) -> Array<Item> {
        guard level < 3, self.isValidation(target) else {
            return []
        }
        var result = Array<Item>()
        let dict = YJJSONModel<Any>.transformToDict(target)
        for (key, value) in dict {
            guard self.isValidation(value) else {
                continue
            }
            let item = Item(obj: value as AnyObject, path: path + "." + key)
            result.append(item)
            result.append(contentsOf: self.captureMemory(target: value, level: level + 1, path: item.path))
        }
        return result
        
    }
    
    func isValidation(_ target: Any) -> Bool {
        let className = "\(type(of: target))"
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
    
}

fileprivate extension NSObject {
    
    @objc
    class func yj_startCaptureMemoryLeaks() {
        self.doesNotRecognizeSelector(#function)
    }
    
    func yj_captureMemoryLeaks() {
        YJLeaks.shared.captureMemoryLeaks(target: self)
    }
    
}



fileprivate extension UINavigationController {
    @objc
    override class func yj_startCaptureMemoryLeaks() {
        self.swizzling(originalSEL: #selector(UINavigationController.popViewController(animated:)), swizzlingSEL: #selector(UINavigationController.yj_popViewController(animated:)))
        self.swizzling(originalSEL: #selector(UINavigationController.popToViewController(_:animated:)), swizzlingSEL: #selector(UINavigationController.yj_popToViewController(_:animated:)))
        self.swizzling(originalSEL: #selector(UINavigationController.popToRootViewController(animated:)), swizzlingSEL: #selector(UINavigationController.yj_popToRootViewController(animated:)))
    }
    
    @objc dynamic func yj_popViewController(animated: Bool) -> UIViewController? {
        guard let vc = self.yj_popViewController(animated: animated) else {
            return nil
        }
        vc.yj_captureMemoryLeaks()
        return vc
    }
    
    @objc dynamic func yj_popToViewController(_ viewController: UIViewController, animated: Bool) -> [UIViewController]? {
        guard let array = self.yj_popToViewController(viewController, animated: animated) else {
            return nil
        }
        for vc in array {
            vc.yj_captureMemoryLeaks()
        }
        return array
    }
    
    @objc dynamic func yj_popToRootViewController(animated: Bool) -> [UIViewController]? {
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
    
    @objc dynamic func yj_dismiss(animated flag: Bool, completion: (() -> Void)? = nil) {
        self.yj_captureMemoryLeaks()
        self.yj_dismiss(animated: flag, completion: completion)
    }
    
}

fileprivate extension UIView {
    
    @objc
    override class func yj_startCaptureMemoryLeaks() {
        self.swizzling(originalSEL: #selector(UIView.removeFromSuperview), swizzlingSEL: #selector(UIView.yj_removeFromSuperview))
    }
    
    @objc dynamic func yj_removeFromSuperview() {
        self.yj_captureMemoryLeaks()
        self.yj_removeFromSuperview()
    }
    
}


