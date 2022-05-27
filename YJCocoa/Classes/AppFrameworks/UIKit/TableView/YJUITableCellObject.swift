//
//  YJUITableCellObject.swift
//  YJCocoa
//
//  HomePage:https://github.com/937447974/YJCocoa
//  YJ技术支持群:557445088
//
//  Created by 阳君 on 2019/5/22.
//  Copyright © 2016-现在 YJCocoa. All rights reserved.
//

import UIKit

/// 点击cell的回调
public typealias YJUITableCellSelectClosure = (_ tableViewManager: YJUITableViewManager, _ cellObject: YJUITableCellObject) -> Void

@objcMembers
open class YJUITableCellObject: NSObject {
    
    /// cell对应的VM
    public var cellModel: Any?
    /// 携带的自定义数据
    public var userInfo: Any?
    /// cell 点击回调
    public var didSelectClosure: YJUITableCellSelectClosure?
    
    /// cell 的类
    public private(set) var cellClass: AnyClass
    /// cell 的缓存，UITableViewCell.reuseIdentifier，默认类名
    public var reuseIdentifier = ""
    /// cell 的位置
    public var indexPath: IndexPath!
    /// cell 的高度
    public var height: CGFloat?
    
    public init(cellClass: AnyClass) {
        self.cellClass = cellClass
        self.reuseIdentifier = NSStringFromClass(cellClass)
    }
    
}
