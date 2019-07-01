//
//  YJTestCollectionViewCell.swift
//  YJCollectionView
//
//  Created by 阳君 on 2019/7/1.
//  Copyright © 2019 YJ. All rights reserved.
//

import UIKit
import YJCocoa

@objcMembers
class YJTestCollectionCellModel: NSObject {
    /// 位置
    var index: String!
}

@objcMembers
class YJTestCollectionViewCell: YJUICollectionViewCell {
    
    lazy var label: UILabel = {
        let _label = UILabel(frame: self.bounds)
        _label.font = UIFont.systemFont(ofSize: 20)
        _label.textAlignment = .center
        return _label
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
    
    override func collectionViewManager(_ collectionViewManager: YJUICollectionViewManager, reloadWith cellObject: YJUICollectionCellObject) {
        super.collectionViewManager(collectionViewManager, reloadWith: cellObject)
        let cm = cellObject.cellModel as? YJTestCollectionCellModel
        self.label.text = cm?.index
    }
    
}
