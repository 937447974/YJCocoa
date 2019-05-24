//
//  YJTestPVCell.swift
//  YJPageView
//
//  Created by 阳君 on 2019/5/24.
//  Copyright © 2019 YJCocoa. All rights reserved.
//

import UIKit
import YJCocoa

class YJTestPVCell: YJUIPageViewCell {
    
    var label: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.label = UILabel(frame: self.view.frame)
        self.label.textAlignment = .center
        self.view.addSubview(self.label)
    }
    
    override func pageViewManager(_ pageViewManager: YJUIPageViewManager, reloadWith cellObject: YJUIPageViewCellObject) {
        super.pageViewManager(pageViewManager, reloadWith: cellObject)
        self.label.text = "\(cellObject.index)"
        print("reloadWith \(self.label.text!)")
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        print("viewDidAppear \(self.cellObject.index)")
    }
    
}


