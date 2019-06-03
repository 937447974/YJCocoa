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
    
    func testDirectory() {
        let director = YJDirectoryS()
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
