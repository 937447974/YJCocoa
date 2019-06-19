//
//  AppDelegate.swift
//  YJFoundation
//
//  Created by 阳君 on 2019/5/6.
//  Copyright © 2019 YJCocoa. All rights reserved.
//

import UIKit
import YJCocoa

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    let timeProfiler = YJTimeProfiler()

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        self.timeProfiler.start()
        YJLog.levels = [.verbose, .debug, .info, .warn, .error]
        self.window = UIWindow(frame: UIScreen.main.bounds)
        self.window?.backgroundColor = UIColor.white
        self.window?.rootViewController = ViewController()
        self.window?.makeKeyAndVisible()
        return true
    }

}

