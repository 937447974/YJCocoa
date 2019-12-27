//
//  UITextViewExt.swift
//  YJCocoa
//
//  HomePage:https://github.com/937447974/YJCocoa
//  YJ技术支持群:557445088
//
//  Created by 阳君 on 2019/10/22.
//  Copyright © 2016-现在 YJCocoa. All rights reserved.
//

import UIKit

fileprivate let fitsTextView = UITextView(frame: CGRect())

public extension UITextView {
    
    /// 纯文本显示计算
    static func sizeThatFits(_ size: CGSize, font: UIFont, text: String?) -> CGSize {
        fitsTextView.contentInset = UIEdgeInsets()
        fitsTextView.font = font
        fitsTextView.text = text
        return fitsTextView.sizeThatFits(size)
    }
    
    /// 富文本显示计算
    static func sizeThatFits(_ size: CGSize, text: NSAttributedString) -> CGSize {
        fitsTextView.contentInset = UIEdgeInsets()
        fitsTextView.attributedText = text
        return fitsTextView.sizeThatFits(size)
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
