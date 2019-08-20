//
//  YJUICollectionViewCell.swift
//  YJCocoa
//
//  HomePage:https://github.com/937447974/YJCocoa
//  YJ技术支持群:557445088
//
//  Created by 阳君 on 2019/5/23.
//  Copyright © 2016-现在 YJCocoa. All rights reserved.
//

import UIKit

@objc
extension UICollectionViewCell {
    
    /// 获取 cell 的显示size
    open class func collectionViewManager(_ collectionViewManager: YJUICollectionViewManager, sizeWith cellObject: YJUICollectionCellObject) -> CGSize {
        return collectionViewManager.flowLayout.itemSize
    }
    
}

@objcMembers
open class YJUICollectionViewCell: UICollectionViewCell {
    
    public private(set) var cellObject: YJUICollectionCellObject!
    public private(set) var collectionViewManager: YJUICollectionViewManager!
    
    override open func collectionViewManager(_ collectionViewManager: YJUICollectionViewManager, reloadWith cellObject: YJUICollectionCellObject) {
        super.collectionViewManager(collectionViewManager, reloadWith: cellObject)
        self.collectionViewManager = collectionViewManager
        self.cellObject = cellObject
    }
    
}
