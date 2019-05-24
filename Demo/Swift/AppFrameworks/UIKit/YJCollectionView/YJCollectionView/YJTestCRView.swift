//
//  YJTestCRView.swift
//  YJCollectionView
//
//  Created by 阳君 on 2019/5/24.
//  Copyright © 2019 YJCocoa. All rights reserved.
//

import UIKit
import YJCocoa

class YJTestCRView: YJUICollectionReusableView {
    
    override func collectionViewManager(_ collectionViewManager: YJUICollectionViewManager, reloadWith cellObject: YJUICollectionCellObject) {
        super.collectionViewManager(collectionViewManager, reloadWith: cellObject)
        guard let color = cellObject.cellModel as? UIColor  else {
            return
        }
        self.backgroundColor = color
    }
    
}
