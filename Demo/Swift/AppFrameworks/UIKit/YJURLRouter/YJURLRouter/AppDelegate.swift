//
//  AppDelegate.swift
//  YJCocoa
//
//  Created by 阳君 on 2019/5/6.
//  Copyright © 2019 YJCocoa. All rights reserved.
//

import UIKit
import YJCocoa

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow? 
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        self.window = UIWindow(frame: UIScreen.main.bounds)
        self.window?.backgroundColor = UIColor.white
        self.window?.rootViewController = UINavigationController(rootViewController: YJMainViewController())
        self.window?.makeKeyAndVisible()
        // 拦截跳转
        YJURLRouter.shared.interceptUnregistered(canOpen: { (url) -> Bool in
            return url.hasPrefix("http")
        }) { (topic, options, handler) in
            YJURLRouter.shared.openURL(url: YJRouterURLMain, options: options, completion: handler)
        }
        return true
    }
    
}

