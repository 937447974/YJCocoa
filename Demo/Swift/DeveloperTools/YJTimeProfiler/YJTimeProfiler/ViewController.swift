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
        // Do any additional setup after loading the view.
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for i in 0..<2 {
            print("......\(i)")
            sleep(1)
        }
    }
    
}

