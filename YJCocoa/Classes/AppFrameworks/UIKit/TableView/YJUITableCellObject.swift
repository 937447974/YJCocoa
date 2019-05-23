//
//  YJUITableCellObject.swift
//  YJTableView
//
//  Created by 阳君 on 2019/5/22.
//  Copyright © 2019 YJCocoa. All rights reserved.
//

import UIKit

/// 点击cell的回调
public typealias YJUITableCellSelectBlock = (_ tableViewManager: YJUITableViewManager, _ cellObject: YJUITableCellObject) -> Void

open class YJUITableCellObject: NSObject {
    
    /// cell对应的VM
    public var cellModel: AnyObject?
    /// 携带的自定义数据
    public var userInfo: AnyObject?
    /// cell 点击回调
    public var didSelectBlock: YJUITableCellSelectBlock?
    
    /// cell 所处位置
    public var indexPath: IndexPath!
    /// UITableViewCell对应的类
    private(set) var cellClass: AnyClass
    /// UITableViewCell对应的类名
    private(set) var cellName = ""
    /// UITableViewCell.reuseIdentifier，默认类名
    public var reuseIdentifier = ""
    
    public init(cellClass: AnyClass) {
        self.cellClass = cellClass
        self.reuseIdentifier = NSStringFromClass(cellClass)
    }
    
}
