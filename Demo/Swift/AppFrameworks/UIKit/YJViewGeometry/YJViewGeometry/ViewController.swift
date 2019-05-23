//
//  ViewController.swift
//  YJViewGeometry
//
//  Created by 阳君 on 2019/5/23.
//  Copyright © 2019 YJCocoa. All rights reserved.
//

import UIKit
import YJCocoa

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let view = UIView.init(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
        view.frameTop = 100
        view.backgroundColor = UIColor.red
        self.view.addSubview(view)
    }

}

