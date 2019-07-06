//
//  YJUICollectionCellObject.swift
//  YJCocoa
//
//  HomePage:https://github.com/937447974/YJCocoa
//  YJ技术支持群:557445088
//
//  Created by 阳君 on 2019/5/23.
//  Copyright © 2016-现在 YJCocoa. All rights reserved.
//

import Foundation

/// 点击cell的回调
public typealias YJUICollectionCellSelectBlock = (_ collectionViewManager: YJUICollectionViewManager, _ cellObject: YJUICollectionCellObject) -> Void

@objcMembers
open class YJUICollectionCellObject: NSObject {
    
    /// cell对应的VM
    public var cellModel: AnyObject?
    /// 携带的自定义数据
    public var userInfo: AnyObject?
    /// cell 点击回调
    public var didSelectBlock: YJUICollectionCellSelectBlock?
    
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
