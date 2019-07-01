//
//  YJTestCollectionReusableView.swift
//  YJCollectionView
//
//  Created by 阳君 on 2019/7/1.
//  Copyright © 2019 YJ. All rights reserved.
//

import UIKit
import YJCocoa

@objcMembers
class YJTestCollectionReusableViewModel: NSObject {
    /// 背景色
    var backgroundColor: UIColor!
}

@objcMembers
class YJTestCollectionReusableView: YJUICollectionReusableView {
    
    override class func collectionViewManager(_ collectionViewManager: YJUICollectionViewManager, referenceSizeFor kind: String, in cellObject: YJUICollectionCellObject) -> CGSize {
        return CGSize(width: 10, height: 100)
    }
    
    override func collectionViewManager(_ collectionViewManager: YJUICollectionViewManager, reloadWith cellObject: YJUICollectionCellObject) {
        super.collectionViewManager(collectionViewManager, reloadWith: cellObject)
        let cm = cellObject.cellModel as? YJTestCollectionReusableViewModel
        self.backgroundColor = cm?.backgroundColor
    }
    
}
