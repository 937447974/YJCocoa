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
    
    /// cell 所处位置
    public var indexPath: IndexPath!
    /// UITableViewCell对应的类
    private(set) var cellClass: AnyClass
    /// UITableViewCell.reuseIdentifier，默认类名
    public var reuseIdentifier = ""
    
    public init(cellClass: AnyClass) {
        self.cellClass = cellClass
        self.reuseIdentifier = NSStringFromClass(cellClass)
    }
    
}
