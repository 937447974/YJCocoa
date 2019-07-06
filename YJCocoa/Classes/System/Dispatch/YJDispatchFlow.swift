//
//  YJDispatchFlow.swift
//  YJCocoa
//
//  HomePage:https://github.com/937447974/YJCocoa
//  YJ技术支持群:557445088
//
//  Created by 阳君 on 2019/5/30.
//  Copyright © 2016-现在 YJCocoa. All rights reserved.
//

import UIKit

public typealias YJDispatchFlowBlock = (_ data: Any?) -> Any?

/// 调度流
open class YJDispatchFlow: NSObject {
    
    private var work: YJDispatchFlowBlock!
    private var queue: DispatchQueue?
    private var isWait = false
    
    private var next: YJDispatchFlow?
    
    public override init() {
        super.init()
    }
    
    private init(queue: DispatchQueue = DispatchQueue.global(qos: .default), execute work: @escaping YJDispatchFlowBlock) {
        super.init()
        self.queue = queue
        self.work = work
        self.isWait = true
    }
    
    /**
     * 提交调度操作
     * - Parameter queue: 执行的队列
     * - Parameter work: 执行的操作
     */
    public func async(queue: DispatchQueue = DispatchQueue.global(qos: .default), execute work: @escaping YJDispatchFlowBlock) -> YJDispatchFlow {
        self.next = YJDispatchFlow(queue: queue, execute: work)
        self.execute(data: nil)
        return self.next!
    }
    
    /// 取消调度流
    public func cancel() {
        self.queue = nil
        self.next?.cancel()
    }
    
    private func execute(data: Any?) {
        if self.isWait {
            return
        }
        guard let flow = self.next else {
            return
        }
        flow.queue?.async {
            flow.queue = nil
            let data = flow.work(data)
            flow.isWait = false
            flow.execute(data: data)
        }
    }
    
}
