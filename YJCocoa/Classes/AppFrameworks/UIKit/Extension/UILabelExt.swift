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
    
    /// 纯文本显示计算
    static func sizeThatFits(_ size: CGSize, numberOfLines: Int = 0, font: UIFont, text: String?) -> CGSize {
        fitsLabel.numberOfLines = numberOfLines
        fitsLabel.font = font
        fitsLabel.text = text
        return fitsLabel.sizeThatFits(size)
    }
    
    /// 富文本显示计算
    static func sizeThatFits(_ size: CGSize, numberOfLines: Int = 0, text: NSAttributedString) -> CGSize {
        fitsLabel.numberOfLines = numberOfLines
        fitsLabel.attributedText = text
        return fitsLabel.sizeThatFits(size)
    }
    
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
