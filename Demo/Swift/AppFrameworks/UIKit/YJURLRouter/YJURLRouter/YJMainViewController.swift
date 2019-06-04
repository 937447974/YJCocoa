//
//  YJMainViewController.swift
//  YJURLRouter
//
//  Created by 阳君 on 2019/6/4.
//  Copyright © 2019 YJCocoa. All rights reserved.
//

import UIKit
import YJCocoa

class YJMainViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "YJMainViewController"
        YJLogDebug("初始化 YJMainViewController")
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        YJURLRouter.shared.openURL(url: YJRouterURLOther, options: ["1":"阳君"]) { (options: Dictionary<String, Any>) in
            YJLogDebug("接收回调数据：\(options)")
        }
    }
    
    override func routerReloadData(with options: Dictionary<String, Any>, completion handler: YJRCompletionHandler?) {
        YJLogDebug("YJMainViewController 接收数据：\(options)")
    }
    
}
