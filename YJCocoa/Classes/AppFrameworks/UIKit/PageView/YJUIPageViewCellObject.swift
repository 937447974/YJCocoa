//
//  YJUIPageViewCellObject.swift
//  Pods
//
//  Created by 阳君 on 2019/5/24.
//

import UIKit

/// pageViewCell对应的模型封装
open class YJUIPageViewCellObject: NSObject {
    
    /// cell对应的VM
    public var cellModel: AnyObject?
    /// 携带的自定义数据
    public var userInfo: AnyObject?
    
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
