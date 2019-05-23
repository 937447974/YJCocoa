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

class YJUICollectionViewCell: UICollectionViewCell {
    
}
