//
//  NSAttributedStringExt.swift
//  YJCocoa
//
//  HomePage:https://github.com/937447974/YJCocoa
//  YJ技术支持群:557445088
//
//  Created by 阳君 on 2019/9/2.
//  Copyright © 2016-现在 YJCocoa. All rights reserved.
//

import UIKit

public extension NSAttributedString {
    
    /// 通过 string 初始化
    convenience init(string: String, color: UIColor, font: UIFont) {
        let attributes: [NSAttributedString.Key : Any] = [.font : font, .foregroundColor: color]
        self.init(string: string, attributes: attributes)
    }
    
    /// 通过 UIImage 初始化
    convenience init(image: UIImage) {
        self.init(attachment: NSTextAttachment(image: image, bounds: CGRect(origin: CGPoint(), size: image.size)))
    }
    
}

public extension NSMutableAttributedString {
    
    /// 安全 addAttribute
    func addAttributeSafe(_ name: NSAttributedString.Key, value: Any, range: NSRange) {
        if self.length < range.location + range.length { return }
        self.addAttribute(name, value: value, range: range)
    }
    
    /// 安全 addAttributes
    func addAttributesSafe(_ attrs: [NSAttributedString.Key : Any], range: NSRange) {
        if self.length < range.location + range.length { return }
        self.addAttributes(attrs, range: range)
    }
    
}
