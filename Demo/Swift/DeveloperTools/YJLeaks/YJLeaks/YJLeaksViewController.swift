//
//  YJLeaksViewController.swift
//  YJLeaks
//
//  Created by 阳君 on 2019/6/17.
//  Copyright © 2019 YJCocoa. All rights reserved.
//

import UIKit
import YJCocoa
import HandyJSON

var obj: Any?

class YJLeaksViewController: UIViewController & HandyJSON  {
    
    var leakView = YJLeaksView(frame: CGRect(x: 100, y: 100, width: 100, height: 100))
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.green
        self.testProperty()
    }
    
    func testVC() {
        obj = self
    }
    
    func testProperty() {
        self.leakView.backgroundColor = UIColor.white
        self.view.addSubview(self.leakView)
        obj = self.leakView
    }
 
}
