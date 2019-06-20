//
//  ViewController.swift
//  YJViewControllerTransitioning
//
//  Created by 阳君 on 2019/6/19.
//  Copyright © 2019 YJCocoa. All rights reserved.
//

import UIKit
import YJCocoa

class ViewController: UIViewController {
    
    var vcTransitioning = YJUIViewControllerTransitioning()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.green
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.testPresentDismiss()
//        self.testPushPop()
    }
    
    func testPresentDismiss() {
        let nc = UINavigationController(rootViewController: ViewController2())
        let pushAT = YJUIPresentVCAnimatedTransitioning()
        let popAT = YJUIDismissVCAnimatedTransitioning()
        self.vcTransitioning.setPushAT(pushAT, popAT: popAT, popVC: nc)
        nc.transitioningDelegate = self.vcTransitioning
        self.present(nc, animated: true, completion: nil)
    }
    
    func testPushPop() {
        let vc = ViewController2();
        let pushAT = YJUIPushVCAnimatedTransitioning()
        let popAT = YJUIPopVCAnimatedTransitioning()
        self.vcTransitioning.setPushAT(pushAT, popAT: popAT, popVC: vc)
        self.navigationController?.delegate = self.vcTransitioning
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
}


class ViewController2: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.red
    }
    
}

