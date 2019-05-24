//
//  YJUICollectionViewCell.swift
//  YJCollectionView
//
//  Created by 阳君 on 2019/5/23.
//  Copyright © 2019 YJCocoa. All rights reserved.
//

import UIKit

@objc extension UICollectionViewCell {
    
    /// 获取 cell 的显示size
    open class func collectionViewManager(_ collectionViewManager: YJUICollectionViewManager, sizeWith cellObject: YJUICollectionCellObject) -> CGSize {
        return collectionViewManager.flowLayout.itemSize
    }
    
}

open class YJUICollectionViewCell: UICollectionViewCell {
    
    private(set) var cellObject: YJUICollectionCellObject!
    private(set) var collectionViewManager: YJUICollectionViewManager!
    
    override open func collectionViewManager(_ collectionViewManager: YJUICollectionViewManager, reloadWith cellObject: YJUICollectionCellObject) {
        super.collectionViewManager(collectionViewManager, reloadWith: cellObject)
        self.collectionViewManager = collectionViewManager
        self.cellObject = cellObject
    }
    
}
