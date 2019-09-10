//
//  UIWindowExt.swift
//  YJCocoa
//
//  HomePage:https://github.com/937447974/YJCocoa
//  YJ技术支持群:557445088
//
//  Created by 阳君 on 2019/9/4.
//  Copyright © 2019 YJCocoa. All rights reserved.
//

import UIKit

public extension UIWindow {
    
    /// 当前 UIWindow
    static var current: UIWindow? {
        let frontToBackWindows = UIApplication.shared.windows.reversed()
        for window in frontToBackWindows {
            if window.isKeyWindow, window.windowLevel == .normal, window.screen == UIScreen.main, !window.isHidden && window.alpha > 0 {
                return window
            }
        }
        return nil
    }
    
}
