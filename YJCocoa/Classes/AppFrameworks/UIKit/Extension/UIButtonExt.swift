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
    
    /// 设置标题相关
    /// - parameter title: 标题
    /// - parameter font: 字体大小
    /// - parameter color: 字体颜色
    /// - parameter highlightedColor: 点击高亮，默认 color 的 0.75 透明度
    func setTitle(_ title: String, font: UIFont?, color: UIColor?, highlightedColor: UIColor?) {
        self.setTitle(title, for: .normal)
        if let font = font {
            self.titleLabel?.font = font
        }
        self.setTitleColor(color, for: .normal)
        self.setTitleColor(highlightedColor ?? color?.withAlphaComponent(0.75), for: .highlighted)
    }
    
    /// 设置图片相关
    /// - parameter image: 标题
    /// - parameter highlightedImage: 高亮图片，默认 image 的 0.75 透明度
    func setImage(_ image: UIImage?, highlightedImage: UIImage?) {
        self.setImage(image, for: .normal)
        self.setImage(highlightedImage ?? image?.withAlphaComponent(0.75), for: .highlighted)
    }

}
