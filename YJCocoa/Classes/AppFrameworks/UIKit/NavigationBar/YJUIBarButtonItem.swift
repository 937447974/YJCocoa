//
//  YJUIBarButtonItem.swift
//  Pods
//
//  Created by 阳君 on 2019/6/19.
//

import UIKit

/// UINavigationItem.*BarButtonItem
open class YJUIBarButtonItem: NSObject {
    
    /// 按钮
    public let button = UIButton(frame: CGRect(x: 0, y: 0, width: 0, height: 30))
    
    /// 初始化
    public convenience init(touchUpInside: @escaping ((_ button: UIButton) -> ())) {
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
        let _font = font ?? UIFont.systemFont(ofSize: 14)
        let _color = color ?? UINavigationBar.appearance().tintColor
        self.button.setTitle(title, font: _font, color: _color, highlightedColor: highlightedColor)
    }
    
    /// UIBarButtonItem
    open func buildBarButtonItem() -> UIBarButtonItem {
        let size = self.button.sizeThatFits(CGSize(width: 0, height: 30))
        self.button.frameWidth = size.width > 25 ? size.width : 25
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
