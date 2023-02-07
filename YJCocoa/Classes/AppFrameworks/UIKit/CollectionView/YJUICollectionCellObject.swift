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
import UIKit

/// 点击cell的回调
public typealias YJUICollectionCellSelectClosure = (_ collectionViewManager: YJUICollectionViewManager, _ cellObject: YJUICollectionCellObject) -> Void

@objcMembers
open class YJUICollectionCellObject: NSObject {
    
    /// cell对应的VM
    public var cellModel: Any?
    /// 携带的自定义数据
    public var userInfo: Any?
    /// cell 点击回调
    public var didSelectClosure: YJUICollectionCellSelectClosure?
    
    /// cell 所处位置
    public var indexPath: IndexPath!
    /// cell 的缓存大小
    public var size: CGSize?
    /// UITableViewCell对应的类
    public private(set) var cellClass: UICollectionReusableView.Type
    /// UITableViewCell.reuseIdentifier，默认类名
    public var reuseIdentifier = ""
    
    public init(cellClass: UICollectionReusableView.Type) {
        self.cellClass = cellClass
        self.reuseIdentifier = NSStringFromClass(cellClass)
    }
    
}
