//
//  YJDispatchQueue.swift
//  YJCocoa
//
//  HomePage:https://github.com/937447974/YJCocoa
//  YJ技术支持群:557445088
//
//  Created by 阳君 on 2019/5/30.
//  Copyright © 2016-现在 YJCocoa. All rights reserved.
//

import UIKit

public typealias YJDispatchWork = () -> Void

public extension DispatchQueue {
    
    // MARK: main queue
    /// main queue 同步执行
    class func syncMain(_ work: @escaping YJDispatchWork) {
        if pthread_main_np() == 0 {
            DispatchQueue.main.sync(execute: work)
        } else {
            work()
        }
    }
    
    /// main queue 异步执行
    class func asyncMain(_ work: @escaping YJDispatchWork) {
        DispatchQueue.main.async(execute: work)
    }
    
    /// main queue 延时执行
    class func afterMain(delayInSeconds: TimeInterval, execute work: @escaping YJDispatchWork) {
        DispatchQueue.main.asyncAfter(deadline: .now() + delayInSeconds, execute: work)
    }
    
    // MARK: default queue
    /// default queue 异步执行
    class func asyncDefault(_ work: @escaping YJDispatchWork) {
        DispatchQueue.global(qos: .default).async(execute: work)
    }
    
    /// default queue 延时执行
    class func afterDefault(delayInSeconds: TimeInterval, execute work: @escaping YJDispatchWork) {
        DispatchQueue.global(qos: .default).asyncAfter(deadline: .now() + delayInSeconds, execute: work)
    }
    
    /// background queue 异步执行
    class func asyncBackground(_ work: @escaping YJDispatchWork) {
        DispatchQueue.global(qos: .background).async(execute: work)
    }
    
    /// serial queue 异步执行
    class func asyncSerial(_ work: @escaping YJDispatchWork) {
        YJDispatchQueue.serial.async(work)
    }
    
    /// concurrent queue 异步执行
    class func asyncConcurrent(_ work: @escaping YJDispatchWork) {
        YJDispatchQueue.concurrent.async(work)
    }
}

/// 调度队列
@objcMembers
open class YJDispatchQueue: NSObject {
    
    var queue: DispatchQueue!
    var semaphore: DispatchSemaphore!
    let key = DispatchSpecificKey<String>()
    
    /// 串行
    public static var serial: YJDispatchQueue = {
        let queue = DispatchQueue(label: "com.yjcocoa.serial")
        return YJDispatchQueue(queue: queue, maxConcurrent: 1)
    }()
    /// 并行
    public static var concurrent: YJDispatchQueue = {
        let queue = DispatchQueue(label: "com.yjcocoa.concurrent", attributes: DispatchQueue.Attributes.concurrent)
        return YJDispatchQueue(queue: queue, maxConcurrent: 16)
    }()
    
    
    /**
     * init
     * - Parameter queue:         队列
     * - Parameter maxConcurrent: 最大并发数
     */
    public init(queue: DispatchQueue, maxConcurrent: Int) {
        self.queue = queue
        self.semaphore = DispatchSemaphore(value: maxConcurrent)
        self.queue.setSpecific(key: self.key, value: "yj.dispatch.queue")
    }
    
    /// 同步执行
    public func sync(_ work: @escaping YJDispatchWork) {
        self.execute(async: false, work: work)
    }
    
    /// 异步执行
    public func async(_ work: @escaping YJDispatchWork) {
        self.execute(async: true, work: work)
    }
    
    private func execute(async: Bool, work: @escaping YJDispatchWork) {
        let semaphoreWork = {[weak self] in
            self?.semaphore.wait()
            work();
            self?.semaphore.signal()
        }
        if DispatchQueue.getSpecific(key: self.key) != nil {
            work();
        } else if async {
            self.queue.async(execute: semaphoreWork)
        } else {
            self.queue.sync(execute: semaphoreWork)
        }
    }
    
}

