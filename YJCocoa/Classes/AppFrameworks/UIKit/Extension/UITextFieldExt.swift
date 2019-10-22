//
//  UITextFieldExt.swift
//  YJCocoa
//
//  HomePage:https://github.com/937447974/YJCocoa
//  YJ技术支持群:557445088
//
//  Created by 阳君 on 2019/10/22.
//  Copyright © 2016-现在 YJCocoa. All rights reserved.
//

import UIKit

public extension UITextField {
    
    /// 设置标题
    /// - parameter color: 字体颜色
    /// - parameter font: 字体大小
    /// - parameter text: 标题
    
    func setText(_ text: String? = nil, font: UIFont, color: UIColor) {
        self.textColor = color
        self.text = text
        self.font = font
    }
    
}
