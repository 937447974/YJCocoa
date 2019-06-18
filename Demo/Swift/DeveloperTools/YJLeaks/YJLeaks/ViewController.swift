//
//  ViewController.swift
//  YJLeaks
//
//  Created by 阳君 on 2019/6/17.
//  Copyright © 2019 YJCocoa. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.navigationController?.pushViewController(YJLeaksViewController(), animated: true)
    }
    
    
}

