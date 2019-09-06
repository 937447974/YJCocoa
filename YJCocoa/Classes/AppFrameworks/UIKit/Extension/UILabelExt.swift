//
//  UILabelExt.swift
//  YJCocoa
//
//  HomePage:https://github.com/937447974/YJCocoa
//  YJ技术支持群:557445088
//
//  Created by 阳君 on 2019/9/6.
//  Copyright © 2019 YJCocoa. All rights reserved.
//

import UIKit

fileprivate let fitsLabel = UILabel(frame: CGRect())

public extension UILabel {
    
    /// 显示计算
    static func sizeThatFits(_ size: CGSize, numberOfLines: Int = 0, font: UIFont, text: String?) -> CGSize {
        fitsLabel.numberOfLines = numberOfLines
        fitsLabel.font = font
        fitsLabel.text = text
        return fitsLabel.sizeThatFits(size)
    }
    
}
