//
//  ViewController.swift
//  YJTableView
//
//  Created by 阳君 on 2019/5/22.
//  Copyright © 2019 YJCocoa. All rights reserved.
//

import UIKit
import YJCocoa

class ViewController: UIViewController {
    
    lazy var tableView: YJUITableView = {
        let tableView = YJUITableView.init(frame: self.view.bounds, style: .plain)
        tableView.delegate = tableView.manamger
        tableView.dataSource = tableView.manamger
        return tableView
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.edgesForExtendedLayout = UIRectEdge.init();
//        self.automaticallyAdjustsScrollViewInsets = false;
        self.view.addSubview(self.tableView)
        self.testData()
    }
    
    func testData() {
        for i in 0..<50 {
            let cm = YJTestTVCellModel()
            cm.userName = "阳君-\(i)"
            let co = YJTestTVCell.cellObject(with: cm)
            self.tableView.dataSourceCellFirst.append(co)
        }
        self.tableView.reloadData()
    }
    
}

