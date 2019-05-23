//
//  YJTestTVCell.swift
//  YJTableView
//
//  Created by 阳君 on 2019/5/23.
//  Copyright © 2019 YJCocoa. All rights reserved.
//

import UIKit
import YJCocoa

class YJTestTVCellModel {
    var userName = ""
}

class YJTestTVCell: YJUITableViewCell {
    
    lazy var label: UILabel = {
        return UILabel.init(frame: self.bounds)
    }()
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        self.contentView.addSubview(self.label)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.label.frame = self.bounds
    }
    
    // MARK: YJCocoa
    override class func tableViewManager(_ tableViewManager: YJUITableViewManager, heightWith cellObject: YJUITableCellObject) -> CGFloat {
        return CGFloat(2 * cellObject.indexPath.row + 40)
    }
    
    override func tableViewManager(_ tableViewManager: YJUITableViewManager, reloadWith cellObject: YJUITableCellObject) {
        super.tableViewManager(tableViewManager, reloadWith: cellObject)
        guard let cm = cellObject.cellModel as? YJTestTVCellModel else {
            return
        }
        self.label.text = cm.userName
    }
    
}
