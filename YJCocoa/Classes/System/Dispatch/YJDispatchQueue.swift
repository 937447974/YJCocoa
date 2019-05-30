//
//  YJDispatchQueue.swift
//  Pods
//
//  Created by 阳君 on 2019/5/30.
//

import UIKit

public typealias YJDispatchBlock = () -> Void

// MARK: main queue
/// main queue 同步执行
public func dispatch_sync_main(block: @escaping YJDispatchBlock) {
    DispatchQueue.main.async(execute: block)
}

/// main queue 异步执行
public func dispatch_async_main(block: @escaping YJDispatchBlock) {
    DispatchQueue.main.async(execute: block)
}

/// main queue 延时执行
public func dispatch_after_main(delayInSeconds: TimeInterval, block: @escaping YJDispatchBlock) {
    DispatchQueue.main.asyncAfter(deadline: .now() + delayInSeconds, execute: block)
}

// MARK: default queue
/// default queue 异步执行
public func dispatch_async_default(block: @escaping YJDispatchBlock) {
    DispatchQueue.global(qos: .default).async(execute: block)
}

/// default queue 延时执行
public func dispatch_after_default(delayInSeconds: TimeInterval, block: @escaping YJDispatchBlock) {
    DispatchQueue.global(qos: .default).asyncAfter(deadline: .now() + delayInSeconds, execute: block)
}

// MARK: background queue
/// background queue 异步执行
public func dispatch_async_background(block: @escaping YJDispatchBlock) {
    DispatchQueue.global(qos: .background).async(execute: block)
}

/// serial queue 异步执行
public func dispatch_async_serial(block: @escaping YJDispatchBlock) {
    
}

let queue: DispatchQueue = DispatchQueue(label: "com.zhengwenxiang.con", qos: .utility, attributes: .concurrent)
/// concurrent queue 异步执行
public func dispatch_async_concurrent(block: @escaping YJDispatchBlock) {
    
   
}

/// 调度队列
open class YJDispatchQueue: NSObject {
    
    var queue: DispatchQueue!
    var semaphore: DispatchSemaphore!
    let key = DispatchSpecificKey<String>()
    
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
            semaphoreBlock()
        } else if async {
            self.queue.async(execute: semaphoreBlock)
        } else {
            self.queue.sync(execute: semaphoreBlock)
        }
    }
    
}


