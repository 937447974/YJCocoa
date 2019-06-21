//
//  YJFoundationTests.swift
//  YJFoundationTests
//
//  Created by 阳君 on 2019/5/28.
//  Copyright © 2019 YJCocoa. All rights reserved.
//

import XCTest
@testable import YJCocoa

class YJFoundationTests: XCTestCase {
    
    func testCalendar() {
        let calendar = YJCalendar.current
        print("era:\(calendar.era) year:\(calendar.year) month :\(calendar.month) day:\(calendar.day)")
        print("hour:\(calendar.hour) minute:\(calendar.minute) second:\(calendar.second) nanosecond:\(calendar.nanosecond)")
        print("weekday:\(calendar.weekday) weekOfYear:\(calendar.weekOfYear) yearForWeekOfYear:\(calendar.yearForWeekOfYear) ")
    }
    
    func testDirectory() {
        let director = YJDirectory.shared
        XCTAssertNotNil(director.homeURL)
        XCTAssertNotNil(director.documentURL)
        XCTAssertNotNil(director.libraryURL)
        XCTAssertNotNil(director.cachesURL)
        XCTAssertNotNil(director.tempURL)
        print("homeURL: \(director.homeURL!))")
        print("documentURL: \(director.documentURL!))")
        print("libraryURL: \(director.libraryURL!))")
        print("cachesURL: \(director.cachesURL!))")
        print("tempURL: \(director.tempURL!))")
    }
    
    func testURL() {
        print(YJURL.assemblyParams(nil, params: ["wd" : "阳君"], encode: false))
        print(YJURL.assemblyParams("http://www.baidu.com", params: [:], encode: true))
        print(YJURL.assemblyParams("http://www.baidu.com?rsv_sug7=101", params: ["wd":"阳君"], encode: true))
        print(YJURL.analysisParams("https://www.baidu.com?rsv_sug7=101&wd=%E9%98%B3%E5%90%9B", decode: true))
    }
    
    func testKVO() {
        class TestKVO : NSObject {
            @objc dynamic var str = "0"
            deinit {
                print("TestKVO deinit")
            }
        }
        let target = TestKVO()
        func auto() {
            let observer = TestKVO()
            target.addObserver(observer, forKeyPath: "str") { (oldValue: Any?, newValue: Any?) in
                print("1- \(oldValue!) - \(newValue!)")
            }
            target.str = "1"
            target.addObserver(observer, forKeyPath: "str") { (oldValue: Any?, newValue: Any?) in
                print("2 - \(oldValue!) - \(newValue!)")
            }
            target.str = "1"
            target.str = "2"
        }
        auto()
        target.str = "3"
        print("end")
    }
    
    func testLog() {
        YJLogVerbose("verbose")
        YJLogDebug("debug")
        YJLogInfo("info")
        YJLogWarn("warn")
        YJLogError("error")
    }
    
    func testNotification() {
        let name = NSNotification.Name(rawValue: "test")
        func auto() {
            let target = NSObject()
            NotificationCenter.default.addObserver(target, name: name) { (notification: Notification) in
                print("\(notification.name.rawValue) \(notification.object!)")
            }
            NotificationCenter.default.post(name: name, object: "obj")
        }
        auto()
        NotificationCenter.default.post(name: name, object: "obj1")
    }
    
    var scheduler = YJScheduler()
    func testScheduler() {
        let subscriber = UIViewController()
        let topic = "test"
        // 订阅发布
        self.scheduler.subscribe(topic: topic, subscriber: subscriber, queue: .main) { (data: Any?, handler: YJSPublishHandler?) in
            print("接受发送数据： \(data ?? "nil")")
            if handler != nil {
                handler!("data2")
            }
        }
        self.scheduler.publish(topic: topic, data: "data1", serial: false) { (data: Any?) in
            print("接受回调数据1： \(data ?? "nil")")
        }
        self.scheduler.removeSubscribe(subscriber: subscriber)
        self.scheduler.publish(topic: topic, data: "data2")
        // 拦截
        self.scheduler.intercept(interceptor: nil, canHandler: { (topic: String) -> Bool in
            return topic == "test1"
        }, completion: { (topic: String, data: Any?, publishHandler: YJSPublishHandler?) in
            print("接受拦截数据2： \(data ?? "nil")")
            if publishHandler != nil {publishHandler!("data3")}
        })
        self.scheduler.publish(topic: "test1", data: "data3", serial: false) { (data: Any?) in
            print("接受回调数据3： \(data ?? "nil")")
        }
    }
    
}


// MARK: - Safety
extension YJFoundationTests: NSCacheDelegate {
    
    func testSafetyDictionary() {
        let dict = YJSafetyDictionary()
        dict.setObject(1, forKey: "2" as NSString)
        print("\(dict) count:\(dict.count)")
        print("obj:\(dict.object(forKey: "2") ?? "")")
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
        print("\(cache) count:\(cache.count) allKeys:\(cache.allKeys) allValues:\(cache.allValues)")
        cache.countLimit = 1;
    }
    
    func cache(_ cache: NSCache<AnyObject, AnyObject>, willEvictObject obj: Any) {
        print("\(NSStringFromSelector(#function)) \(obj)")
        
    }
    
}

// MARK: - Swizzling
extension YJFoundationTests {
    
    class TestSwizzling: NSObject {
        @objc dynamic func test1() { print("\(#function) 1") }
        @objc dynamic func test2() { print("\(#function) 2") }
    }
    
    func testSwizzling() {
        let originalSEL = #selector(TestSwizzling.test1)
        let swizzlingSEL = #selector(TestSwizzling.test2)
        TestSwizzling.swizzling(originalSEL: originalSEL, swizzlingSEL: swizzlingSEL)
        TestSwizzling.swizzling(originalSEL: originalSEL, swizzlingSEL: swizzlingSEL)
        TestSwizzling().test1()
        TestSwizzling.swizzling(originalSEL: swizzlingSEL, swizzlingSEL: originalSEL)
        TestSwizzling().test1()
    }
    
}
