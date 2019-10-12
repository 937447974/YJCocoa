//
//  YJUIBarButtonItem.swift
//  YJCocoa
//
//  HomePage:https://github.com/937447974/YJCocoa
//  YJ技术支持群:557445088
//
//  Created by 阳君 on 2019/6/19.
//  Copyright © 2016-现在 YJCocoa. All rights reserved.
//

import UIKit

/// UINavigationItem.*BarButtonItem
@objcMembers
open class YJUIBarButtonItem: NSObject {
    
    /// 按钮
    public let button = UIButton(frame: CGRect())
    
    /// 初始化
    public convenience init(touchUpInside: @escaping UIButtonTouchClosure) {
        self.init()
        self.button.touchUpInsideClosure = { (button: Any) in
            touchUpInside(button as! UIButton)
        }
    }
    
    /// 设置标题相关
    /// - parameter title: 标题
    /// - parameter font: 字体大小，默认14
    /// - parameter color: 字体颜色，默认 UINavigationBar.barTintColor
    /// - parameter highlightedColor: 点击高亮，默认 color 的 0.75 透明度
    open func setTitle(_ title: String, font: UIFont?, color: UIColor?, highlightedColor: UIColor?) {
        let font = font ?? UIFont.systemFont(ofSize: 14)
        let color = color ?? UINavigationBar.appearance().tintColor
        self.button.setTitle(title, font: font, color: color, highlightedColor: highlightedColor)
    }
    
    /// UIBarButtonItem
    open func buildBarButtonItem() -> UIBarButtonItem {
        self.button.sizeToFit()
        if self.button.frameWidth < 30 {
            self.button.frameWidth = 30
        }
        return UIBarButtonItem(customView: self.button)
    }
    
    /// 构建返回按钮UIBarButtonItem
    open func buildBackBarButtonItem() -> UIBarButtonItem {
        let item = self.buildBarButtonItem()
        self.button.frameWidth += 3;
        self.button.contentHorizontalAlignment = .left
        return item;
    }
    
}
