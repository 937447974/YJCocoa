//
//  YJTimer.swift
//  YJCocoa
//
//  HomePage:https://github.com/937447974/YJCocoa
//  YJ技术支持群:557445088
//
//  Created by 阳君 on 2019/6/3.
//  Copyright © 2016-现在 YJCocoa. All rights reserved.
//

import UIKit

public typealias YJTimerBlock = (_ target: AnyObject, _ timer: YJTimer) -> Void

/// Timer 计时器
@objcMembers
open class YJTimer: NSObject {
    
    public private(set) var timer: Timer!
    /// 携带的数据
    public var userInfo: Any?
    
    var block: YJTimerBlock!
    weak var target: AnyObject?
    
    /// 初始化，并添加到当前 RunLoop 的 common Mode
    /// - parameter timeInterval: 时间间隔
    /// - parameter target: block回调对象，target释放事，timer 自动释放
    /// - parameter repeats: 是否重复执行
    /// - parameter block: 回调
    public init(timeInterval: TimeInterval, target: AnyObject, repeats: Bool, block: @escaping YJTimerBlock) {
        super.init()
        self.block = block
        self.target = target
        self.timer = Timer.scheduledTimer(timeInterval: timeInterval, target: self, selector: #selector(YJTimer.autoUpdateTime) , userInfo: nil, repeats: repeats)
        RunLoop.current.add(self.timer, forMode: RunLoop.Mode.common)
    }
    
    deinit {
        YJLogVerbose("[YJCocoa] timer 释放")
    }
    
    @objc
    func autoUpdateTime() {
        guard let target = self.target else {
            self.timer.invalidate()
            return
        }
        self.block(target, self)
    }
    
    /// 手动释放计时器
    open func invalidate() {
        self.timer.invalidate()
    }
    
}
