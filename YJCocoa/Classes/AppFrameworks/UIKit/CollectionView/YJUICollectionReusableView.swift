//
//  YJUICollectionReusableView.swift
//  YJTableView
//
//  Created by 阳君 on 2019/5/23.
//  Copyright © 2019 YJCocoa. All rights reserved.
//

import UIKit

@objc extension UICollectionReusableView {
    
    /// 获取 YJUICollectionCellObject
    open class func cellObject() -> YJUICollectionCellObject {
        return YJUICollectionCellObject(cellClass: self)
    }
    
    /// 获取 YJUICollectionCellObject 并自动填充模型
    open class func cellObject(withCellModel cellModel:AnyObject) -> YJUICollectionCellObject {
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
    func collectionViewManager(_ collectionViewManager: YJUICollectionViewManager, reloadWith cellObject: YJUICollectionCellObject) {}
    
}

class YJUICollectionReusableView: UICollectionReusableView {
    
}
