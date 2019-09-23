//
//  UIViewControllerExt.swift
//  YJCocoa
//
//  HomePage:https://github.com/937447974/YJCocoa
//  YJ技术支持群:557445088
//
//  Created by 阳君 on 2019/8/22.
//  Copyright © 2016-现在 YJCocoa. All rights reserved.
//

import UIKit

fileprivate func currentController() -> UIViewController? {
    guard let keyWindow = UIWindow.current else {
        return UIApplication.shared.keyWindow?.rootViewController
    }
    func currentController(with view: UIView, depth: Int) -> UIViewController? {
        guard depth < 3 else { return nil }
        for subview in view.subviews.reversed() {
            if let vc = subview.next as? UIViewController {
                return vc
            } else if let vc = currentController(with: subview, depth: depth + 1) {
                return vc
            }
        }
        return nil
    }
    return currentController(with: keyWindow, depth: 0)
}

public extension UIViewController {
    
    /// 当前 UIViewController
    static var current: UIViewController? {
        var result = currentController()
        if let tabBarController = result as? UITabBarController {
            result = tabBarController.selectedViewController
        }
        if let navigationController = result as? UINavigationController {
            result = navigationController.topViewController
        }
        return result
    }
    
    /// 返回上个页面
    /// - parameter animated: 是否动画
    func pop(animated flag: Bool) {
        guard let nc = self.navigationController else {
            self.dismiss(animated: flag, completion: nil)
            return
        }
        if (nc.viewControllers.count == 1) {
            self.dismiss(animated: flag, completion: nil)
        } else {
            nc.popViewController(animated: flag)
        }
    }
    
}

