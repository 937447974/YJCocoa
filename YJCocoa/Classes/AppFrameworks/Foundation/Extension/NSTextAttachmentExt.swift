//
//  NSTextAttachmentExt.swift
//  YJCocoa
//
//  HomePage:https://github.com/937447974/YJCocoa
//  YJ技术支持群:557445088
//
//  Created by 阳君 on 2019/9/18.
//  Copyright © 2016-现在 YJCocoa. All rights reserved.
//

import UIKit

public extension NSTextAttachment {
    
    /// 通过 UIImage 初始化
    convenience init(image: UIImage, bounds: CGRect) {
        self.init()
        self.image = image
        self.bounds = bounds
    }
    
}

