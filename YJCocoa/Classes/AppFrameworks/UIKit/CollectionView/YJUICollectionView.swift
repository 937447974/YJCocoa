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
    public var manamger: YJUICollectionViewManager!
    /// header 数据源
    public var dataSourceHeader: Array<YJUICollectionCellObject> {
        get {return self.manamger.dataSourceHeader}
        set {self.manamger.dataSourceHeader = newValue}
    }
    /// footer 数据源
    public var dataSourceFooter: Array<YJUICollectionCellObject> {
        get {return self.manamger.dataSourceFooter}
        set {self.manamger.dataSourceFooter = newValue}
    }
    /// cell 数据源
    public var dataSourceCell: Array<Array<YJUICollectionCellObject>> {
        get {return self.manamger.dataSourceCell}
        set {self.manamger.dataSourceCell = newValue}
    }
    /// cell 第一组数据源
    public var dataSourceCellFirst: Array<YJUICollectionCellObject> {
        get {return self.manamger.dataSourceCellFirst}
        set {self.manamger.dataSourceCellFirst = newValue}
    }
    
    override public init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        super.init(frame: frame, collectionViewLayout: layout)
        self.manamger = YJUICollectionViewManager(collectionView: self)
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
