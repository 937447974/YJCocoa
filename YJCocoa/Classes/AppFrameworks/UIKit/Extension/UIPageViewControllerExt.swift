//
//  UIPageViewControllerExt.swift
//  YJCocoa
//
//  HomePage:https://github.com/937447974/YJCocoa
//
//  Created by 阳君 on 2020/8/26.
//  Copyright © 2016-现在 YJCocoa. All rights reserved.

import UIKit

/// UIPageViewController 扩展
public extension UIPageViewController {
    
    /// 获取UIScrollView
    func scrollView() -> UIScrollView? {
        for view in self.view.subviews {
            if let sv = view as? UIScrollView {
                return sv
            }
        }
        return nil
    }
    
}
