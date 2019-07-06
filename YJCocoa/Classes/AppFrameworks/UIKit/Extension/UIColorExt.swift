//
//  UIColorExt.swift
//  YJCocoa
//
//  HomePage:https://github.com/937447974/YJCocoa
//  YJ技术支持群:557445088
//
//  Created by 阳君 on 2019/6/19.
//  Copyright © 2016-现在 YJCocoa. All rights reserved.
//

import UIKit

public extension UIColor {
    
    /// 通过十六进制以及透明度获取UIColor
    /// - parameter hex: 十六进制，如 0xFFFFFF
    /// - parameter alpha: 透明度，默认 1
    static func hex(_ hex: Int, alpha: CGFloat = 1) -> UIColor {
        let red = CGFloat((hex & 0xFF0000) >> 16) / 255.0
        let green = CGFloat((hex & 0xFF00) >> 8) / 255.0
        let blue = CGFloat(hex & 0xFF) / 255.0
        return UIColor(red: red, green: green, blue: blue, alpha: alpha)
    }
    
}
