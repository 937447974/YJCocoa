//
//  ViewController.swift
//  YJPageView
//
//  Created by 阳君 on 2019/5/24.
//  Copyright © 2019 YJCocoa. All rights reserved.
//

import UIKit
import YJCocoa

class ViewController: UIViewController {
    
    lazy var pageVC: YJUIPageViewController! = {
        let pageVC = YJUIPageViewController(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)
        pageVC.view.frame = self.view.bounds
        pageVC.manager.isLoop = false
        pageVC.manager.isDisableBounces = true
        return pageVC
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.addChild(self.pageVC)
        self.view.addSubview(self.pageVC.view)
        self.testData()
    }
    
    func testData() {
        for _ in 0..<10 {
            self.pageVC.dataSourceCell.append(YJTestPVCell.cellObject())
        }
        self.pageVC.reloadData()
    }
    
}
