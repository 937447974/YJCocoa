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
    for subview in keyWindow.subviews.reversed() {
        if let vc = subview.next as? UIViewController {
            return vc
        } else if let vc = currentController(with: subview) {
            return vc
        }
    }
    return nil
}

fileprivate func currentController(with subView: UIView) -> UIViewController? {
    for view in subView.subviews.reversed() {
        if let vc = view.next as? UIViewController {
            return vc
        }
    }
    return nil
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

