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

public typealias YJDispatchBlock = () -> Void

// MARK: main queue
/// main queue 同步执行
public func dispatch_sync_main(_ block: @escaping YJDispatchBlock) {
    DispatchQueue.main.async(execute: block)
}

/// main queue 异步执行
public func dispatch_async_main(_ block: @escaping YJDispatchBlock) {
    DispatchQueue.main.async(execute: block)
}

/// main queue 延时执行
public func dispatch_after_main(delayInSeconds: TimeInterval, block: @escaping YJDispatchBlock) {
    DispatchQueue.main.asyncAfter(deadline: .now() + delayInSeconds, execute: block)
}

// MARK: default queue
/// default queue 异步执行
public func dispatch_async_default(_ block: @escaping YJDispatchBlock) {
    DispatchQueue.global(qos: .default).async(execute: block)
}

/// default queue 延时执行
public func dispatch_after_default(delayInSeconds: TimeInterval, block: @escaping YJDispatchBlock) {
    DispatchQueue.global(qos: .default).asyncAfter(deadline: .now() + delayInSeconds, execute: block)
}

/// background queue 异步执行
public func dispatch_async_background(_ block: @escaping YJDispatchBlock) {
    DispatchQueue.global(qos: .background).async(execute: block)
}

/// serial queue 异步执行
public func dispatch_async_serial(_ block: @escaping YJDispatchBlock) {
    YJDispatchQueue.serial.async(execute: block)
}

/// concurrent queue 异步执行
public func dispatch_async_concurrent(_ block: @escaping YJDispatchBlock) {
    YJDispatchQueue.concurrent.async(execute: block)
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
        let queue = DispatchQueue.init(label: "com.codansYC.queue", attributes: DispatchQueue.Attributes.concurrent)
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
    public func sync(execute work: @escaping YJDispatchBlock) {
        self.execute(async: false, work: work)
    }
    
    /// 异步执行
    public func async(execute work: @escaping YJDispatchBlock) {
        self.execute(async: true, work: work)
    }
    
    private func execute(async: Bool, work: @escaping YJDispatchBlock) {
        let semaphoreBlock = {[weak self] in
            self?.semaphore.wait()
            work();
            self?.semaphore.signal()
        }
        if DispatchQueue.getSpecific(key: self.key) != nil {
            work();
        } else if async {
            self.queue.async(execute: semaphoreBlock)
        } else {
            self.queue.sync(execute: semaphoreBlock)
        }
    }
    
}

extension YJDispatchQueue {
    
    public static func syncMain(_ block: @escaping YJDispatchBlock) {
        DispatchQueue.main.async(execute: block)
    }
    
    public static func afterMain(delayInSeconds: TimeInterval, block: @escaping YJDispatchBlock) {
        DispatchQueue.main.asyncAfter(deadline: .now() + delayInSeconds, execute: block)
    }
    
    public static func asyncDefault(_ block: @escaping YJDispatchBlock) {
        DispatchQueue.global(qos: .default).async(execute: block)
    }
    
}


