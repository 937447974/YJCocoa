//
//  UIButtonExt.swift
//  YJCocoa
//
//  HomePage:https://github.com/937447974/YJCocoa
//  YJ技术支持群:557445088
//
//  Created by 阳君 on 2019/6/19.
//  Copyright © 2016-现在 YJCocoa. All rights reserved.
//

import UIKit

public typealias UIButtonTouchClosure =  (_ button: UIButton) -> ()

@objc
public extension UIButton {
    
    /// 设置标题
    /// - parameter title: 标题
    /// - parameter font: 字体大小
    /// - parameter color: 字体颜色
    /// - parameter highlightedColor: 点击高亮，默认 color 的 0.75 透明度
    func setTitle(_ title: String, font: UIFont? = nil, color: UIColor? = nil, highlightedColor: UIColor? = nil) {
        self.setTitle(title, for: .normal)
        if let font = font {
            self.titleLabel?.font = font
        }
        if let color = color {
            self.setTitleColor(color, highlightedColor: highlightedColor)
        }
    }
    
    /// 设置字体颜色
    /// - parameter color: 默认色
    /// - parameter highlighted: 高亮色，默认 color 的 0.75 透明度
    func setTitleColor(_ color: UIColor, highlightedColor: UIColor? = nil) {
        self.setTitleColor(color, for: .normal)
        self.setTitleColor(highlightedColor ?? color.withAlphaComponent(0.75), for: .highlighted)
    }
    
    /// 设置图片
    /// - parameter image: 标题
    /// - parameter highlightedImage: 高亮图片，默认 image 的 0.75 透明度
    func setImage(_ image: UIImage?, highlightedImage: UIImage? = nil) {
        self.setImage(image, for: .normal)
        let highlightedImage = highlightedImage ?? image?.withAlphaComponent(0.75)
        self.setImage(highlightedImage, for: .highlighted)
    }
    
    // 设置背景图片
    /// - parameter color: 默认色
    /// - parameter highlightedColor: 高亮色，默认 color 的 0.75 透明度
    func setBackgroundImage(_ color: UIColor, highlightedColor: UIColor? = nil) {
        self.setBackgroundImage(UIImage.image(with: color, size: self.frameSize), for: .normal)
        let highlightedColor = highlightedColor ?? color.withAlphaComponent(0.75)
        self.setBackgroundImage(UIImage.image(with: highlightedColor, size: self.frameSize), for: .highlighted)
    }
    
}
