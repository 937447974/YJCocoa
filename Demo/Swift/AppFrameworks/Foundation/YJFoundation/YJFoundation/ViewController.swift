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

// MARK: - Calendar
extension ViewController {
    
    func testCalendar() {
        let calendar = YJCalendar.current
        print("era:\(calendar.era) year:\(calendar.year) month :\(calendar.month) day:\(calendar.day)")
        print("hour:\(calendar.hour) minute:\(calendar.minute) second:\(calendar.second) nanosecond:\(calendar.nanosecond)")
        print("weekday:\(calendar.weekday) weekOfYear:\(calendar.weekOfYear) yearForWeekOfYear:\(calendar.yearForWeekOfYear) ")
    }
    
}

// MARK: - Safety
extension ViewController {
    
    func testSafety() {
        //        self.testSafetyDictionary()
        //        self.testSafetyCache()
        self.testDictionary()
    }
    
    func testSafetyDictionary() {
        let dict = YJSafetyDictionary()
        dict.setObject(1, forKey: "2" as NSString)
        NSLog("\(dict) count:\(dict.count)")
        NSLog("obj:\(dict.object(forKey: "2") ?? "")")
    }
    
    func testDictionary() {
        let dict = NSMutableDictionary()
        print("bool: \(dict.bool(forKey: "bool"))")
        print("integer: \(dict.integer(forKey: "integer"))")
        print("float: \(dict.float(forKey: "float"))")
        print("string: \(dict.string(forKey: "string"))")
        print("set: \(dict.set(forKey: "set"))")
        print("array: \(dict.array(forKey: "array"))")
        print("dictionary: \(dict.dictionary(forKey: "dictionary"))")
        print("mutableSet: \(dict.mutableSet(forKey: "mutableSet"))")
        print("mutableArray: \(dict.mutableArray(forKey: "mutableArray"))")
        print("mutableDictionary: \(dict.mutableDictionary(forKey: "mutableDictionary"))")
        print("dict: \(dict))")
        dict.setBool(true, forKey: NSString("bool"))
        dict.setInt(1, forKey: NSString("int"))
        dict.setFloat(1.0, forKey: NSString("float"))
        dict.setString("s", forKey: NSString("string"))
        dict.setSet(NSSet(), forKey: NSString("set"))
        dict.setArray(NSArray(), forKey: NSString("array"))
        dict.setDictionary(NSDictionary(), forKey: NSString("dictionary"))
        print("dict: \(dict))")
    }
    
    func testSafetyCache() {
        let cache = YJSafetyCache<NSString, NSString>()
        cache.delegate = self
        cache.countLimit = 999;
        cache.setObject("1o", forKey: "1")
        cache.setObject("2o", forKey: "2")
        cache.setObject("3o", forKey: "3")
        NSLog("\(cache) count:\(cache.count) allKeys:\(cache.allKeys) allValues:\(cache.allValues)")
        cache.countLimit = 1;
    }
    
    func cache(_ cache: NSCache<AnyObject, AnyObject>, willEvictObject obj: Any) {
        NSLog("\(NSStringFromSelector(#function)) \(obj)")
        
    }
    
}

