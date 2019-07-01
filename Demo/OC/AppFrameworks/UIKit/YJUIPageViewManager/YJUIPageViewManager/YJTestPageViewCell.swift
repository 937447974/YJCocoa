//
//  YJTestPageViewCell.swift
//  YJUIPageViewManager
//
//  Created by 阳君 on 2019/7/1.
//  Copyright © 2019 YJCocoa. All rights reserved.
//

import UIKit
import YJCocoa

class YJTestPageViewCell: YJUIPageViewCell {
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        YJLogDebug("显示 \(self.cellObject.index)")
    }
    
    override func pageViewManager(_ pageViewManager: YJUIPageViewManager, reloadWith cellObject: YJUIPageViewCellObject) {
        super.pageViewManager(pageViewManager, reloadWith: cellObject)
        if cellObject.index % 2 > 0 {
            self.view.backgroundColor = UIColor.red
        } else {
            self.view.backgroundColor = UIColor.green
        }
    }
    
}
