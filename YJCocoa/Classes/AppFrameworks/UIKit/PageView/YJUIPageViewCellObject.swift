//
//  YJUIPageViewCellObject.swift
//  YJCocoa
//
//  HomePage:https://github.com/937447974/YJCocoa
//  YJ技术支持群:557445088
//
//  Created by 阳君 on 2019/5/24.
//  Copyright © 2016-现在 YJCocoa. All rights reserved.
//

import UIKit

/// pageViewCell对应的模型封装
open class YJUIPageViewCellObject: NSObject {
    
    /// cell对应的VM
    public var cellModel: Any?
    /// 携带的自定义数据
    public var userInfo: Any?
    
    /// cell 所处位置
    public var index: Int = 0
    /// YJUIPageViewCell 对应的类
    private(set) var cellClass: AnyClass
    /// YJUIPageViewCell.reuseIdentifier，默认类名
    public var reuseIdentifier = ""
    
    public init(cellClass: AnyClass) {
        self.cellClass = cellClass
        self.reuseIdentifier = NSStringFromClass(cellClass)
    }
    
}
