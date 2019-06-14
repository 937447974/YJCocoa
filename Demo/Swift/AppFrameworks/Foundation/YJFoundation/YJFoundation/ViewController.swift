//
//  ViewController.swift
//  YJFoundation
//
//  Created by 阳君 on 2019/5/6.
//  Copyright © 2019 YJCocoa. All rights reserved.
//

import UIKit
import YJCocoa

class ViewController: UIViewController, NSCacheDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        self.testCalendar()
//        self.testSafety()
//        self.testSingletonCenter()
//        self.testTimer()
    }
    
    func testTimer() {
        let vc = ViewController()
        _ = YJTimer(timeInterval: 1, target: vc, repeats: true, block: { (target:  AnyObject, timer: YJTimer)  in
            YJLogDebug("\(target) 倒计时 done")
        })
        dispatch_after_main(delayInSeconds: 5) {
            print("\(vc)") // block 释放 -> vc 释放 -> YJTimer 自动释放
        }
    }
    
}

// MARK: - SingletonCenter
extension ViewController {
    
    func testSingletonCenter() {
        print(" \(YJWeakSingleton(NSDictionary.self, "Dictionary"))")
        for _ in 0..<5 {
            DispatchQueue.global(qos: .default).async {
                print("1 \(YJStrongSingleton(ViewController.self, nil))")
            }
            DispatchQueue.global(qos: .default).async {
                print(" 2 \(YJStrongSingleton(ViewController.self, "private1"))")
            }
            DispatchQueue.global(qos: .default).async {
                print("  3 \(YJWeakSingleton(ViewController.self, "private1"))")
            }
            DispatchQueue.global(qos: .default).async {
                print("   4 \(YJWeakSingleton(ViewController.self, "private12"))")
            }
        }
    }
    
}
