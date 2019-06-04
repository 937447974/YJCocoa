//
//  YJOtherViewController.swift
//  YJURLRouter
//
//  Created by 阳君 on 2019/6/4.
//  Copyright © 2019 YJCocoa. All rights reserved.
//

import UIKit
import YJCocoa

class YJOtherViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "YJOtherViewController"
        self.view.backgroundColor = UIColor.white
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
//        YJURLRouter.shared.openURL(url: "/main?1=3", options: ["name":"阳君"]) { (options: Dictionary<String, Any>) in
//            YJLogDebug("接收回调数据：\(options)")
//        }
        YJURLRouter.shared.openURL(url: "https://www.baidu.com/s?wd=swift&rsv_spt=1&issp=1&f=8&rsv_bp=1&rsv_idx=2&ie=utf-8&tn=baiduhome_pg", options: ["name":"阳君"]) { (options: Dictionary<String, Any>) in
            YJLogDebug("接收回调数据：\(options)")
        }
    }
    
    override func routerReloadData(with options: Dictionary<String, Any>, completion handler: YJRCompletionHandler?) {
        YJLogDebug("YJOtherViewController 接收数据：\(options)")
        if handler != nil {
            handler!(["回调数据":"操作完成"])
        }
    }
    
}
