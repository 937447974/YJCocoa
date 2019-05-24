//
//  YJTestCVCell.swift
//  YJCollectionView
//
//  Created by 阳君 on 2019/5/24.
//  Copyright © 2019 YJCocoa. All rights reserved.
//

import UIKit
import YJCocoa

class YJTestCVCellModel: NSObject {
    
    var text: String?
    
    init(text: String) {
        self.text = text
    }
    
}

class YJTestCVCell: YJUICollectionViewCell {
    
    lazy var label: UILabel = {
        let label = UILabel(frame: self.bounds)
        label.font = UIFont.systemFont(ofSize: 16)
        label.textAlignment = NSTextAlignment.center
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.green
        self.contentView.addSubview(self.label)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.label.frame = self.bounds
    }
    
    override class func collectionViewManager(_ collectionViewManager: YJUICollectionViewManager, sizeWith cellObject: YJUICollectionCellObject) -> CGSize {
        let width: CGFloat = (collectionViewManager.collectionView.frameWidth - 70)/5
        return CGSize(width: width, height: width)
    }
    
    override func collectionViewManager(_ collectionViewManager: YJUICollectionViewManager, reloadWith cellObject: YJUICollectionCellObject) {
        super.collectionViewManager(collectionViewManager, reloadWith: cellObject)
        guard let cm = cellObject.cellModel as? YJTestCVCellModel else {
            return
        }
        self.label.text = cm.text
    }
    
}

