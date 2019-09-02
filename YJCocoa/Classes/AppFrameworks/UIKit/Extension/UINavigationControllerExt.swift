//
//  UINavigationControllerExt.swift
//  YJCocoa
//
//  HomePage:https://github.com/937447974/YJCocoa
//  YJ技术支持群:557445088
//
//  Created by 阳君 on 2019/8/23.
//  Copyright © 2016-现在 YJCocoa. All rights reserved.
//

import UIKit

public extension UINavigationController {
    
    /// 移除 UIViewController
    func removeViewController(_ viewController: UIViewController) {
        var vcs = [UIViewController]()
        for vc in self.viewControllers {
            if vc != viewController {
                vcs.append(vc)
            }
        }
        if vcs.count != self.viewControllers.count {
            self.setViewControllers(vcs, animated: false)
        }
    }
    
}
