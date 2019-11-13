//
//  YJUICollectionReusableView.swift
//  YJCocoa
//
//  HomePage:https://github.com/937447974/YJCocoa
//  YJ技术支持群:557445088
//
//  Created by 阳君 on 2019/5/23.
//  Copyright © 2016-现在 YJCocoa. All rights reserved.
//

import UIKit

@objc extension UICollectionReusableView {
    
    /// 获取 YJUICollectionCellObject
    public class func cellObject() -> YJUICollectionCellObject {
        return YJUICollectionCellObject(cellClass: self)
    }
    
    /// 获取 YJUICollectionCellObject 并自动填充模型
    public class func cellObject(withCellModel cellModel: Any?) -> YJUICollectionCellObject {
        let co = self.cellObject()
        co.cellModel = cellModel
        return co
    }
    
    /// 获取 cell 的显示size
    open class func collectionViewManager(_ collectionViewManager: YJUICollectionViewManager, referenceSizeFor kind: String, in cellObject: YJUICollectionCellObject) -> CGSize {
        switch kind {
        case UICollectionView.elementKindSectionHeader:
            return collectionViewManager.flowLayout.headerReferenceSize
        case UICollectionView.elementKindSectionFooter:
            return collectionViewManager.flowLayout.footerReferenceSize
        default:
            return CGSize.zero
        }
    }
    
    /// 刷新 UICollectionViewCell
    open func collectionViewManager(_ collectionViewManager: YJUICollectionViewManager, reloadWith cellObject: YJUICollectionCellObject) {}
    
}

open class YJUICollectionReusableView: UICollectionReusableView {
    
    private(set) var cellObject: YJUICollectionCellObject!
    private(set) var collectionViewManager: YJUICollectionViewManager!
    
    override open func collectionViewManager(_ collectionViewManager: YJUICollectionViewManager, reloadWith cellObject: YJUICollectionCellObject) {
        super.collectionViewManager(collectionViewManager, reloadWith: cellObject)
        self.collectionViewManager = collectionViewManager
        self.cellObject = cellObject
    }
    
}
