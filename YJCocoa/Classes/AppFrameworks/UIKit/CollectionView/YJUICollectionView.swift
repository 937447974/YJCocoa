//
//  YJUICollectionView.swift
//  YJCollectionView
//
//  Created by 阳君 on 2019/5/23.
//  Copyright © 2019 YJCocoa. All rights reserved.
//

import UIKit

@objcMembers
open class YJUICollectionView: UICollectionView {

    /// 管理器
    public lazy var manager: YJUICollectionViewManager! = {
        let _manager = YJUICollectionViewManager(collectionView: self)
        self.delegate = _manager
        self.dataSource = _manager
        return _manager
    }()
    /// header 数据源
    public var dataSourceHeader: Array<YJUICollectionCellObject> {
        get {return self.manager.dataSourceHeader}
        set {self.manager.dataSourceHeader = newValue}
    }
    /// footer 数据源
    public var dataSourceFooter: Array<YJUICollectionCellObject> {
        get {return self.manager.dataSourceFooter}
        set {self.manager.dataSourceFooter = newValue}
    }
    /// cell 数据源
    public var dataSourceCell: Array<Array<YJUICollectionCellObject>> {
        get {return self.manager.dataSourceCell}
        set {self.manager.dataSourceCell = newValue}
    }
    /// cell 第一组数据源
    public var dataSourceCellFirst: Array<YJUICollectionCellObject> {
        get {return self.manager.dataSourceCellFirst}
        set {self.manager.dataSourceCellFirst = newValue}
    }
    
}
