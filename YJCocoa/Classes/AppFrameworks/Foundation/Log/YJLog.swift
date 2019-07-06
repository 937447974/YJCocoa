//
//  YJLog.swift
//  YJCocoa
//
//  HomePage:https://github.com/937447974/YJCocoa
//  YJ技术支持群:557445088
//
//  Created by 阳君 on 2019/5/29.
//  Copyright © 2016-现在 YJCocoa. All rights reserved.
//

import UIKit

/// Verbose 日志
public func YJLogVerbose(_ log: String) {YJLog.logBlock(.verbose, log)}
/// Debug 日志
public func YJLogDebug(_ log: String) {YJLog.logBlock(.debug, log)}
/// Info 日志
public func YJLogInfo(_ log: String) {YJLog.logBlock(.info, log)}
/// Warn 日志
public func YJLogWarn(_ log: String) {YJLog.logBlock(.warn, log)}
/// Error 日志
public func YJLogError(_ log: String) {YJLog.logBlock(.error, log)}


/// 日志打印回调
public typealias YJLogBlock = (_ level: YJLogLevels, _ log: String) -> Void

/// 日志级别
public struct YJLogLevels : OptionSet {
    
    public static let verbose = YJLogLevels(rawValue: 1)
    public static var debug = YJLogLevels(rawValue: 2)
    public static var info = YJLogLevels(rawValue: 4)
    public static var warn = YJLogLevels(rawValue: 8)
    public static var error = YJLogLevels(rawValue: 16)
    
    public let rawValue: Int
    public init(rawValue: Int) {
        self.rawValue = rawValue
    }
    
}

/// 日志输出
public class YJLog : NSObject {
    
    /// 日志级别
    #if DEBUG
    public static var levels: YJLogLevels = [.debug, .info, .warn, .error]
    #else
    public static var levels: YJLogLevels = [.info, .warn, .error]
    #endif
    
    /// 日志输出
    public static var logBlock: YJLogBlock = { (_ levels: YJLogLevels, _ log: String) in
        guard YJLog.levels.contains(levels) else {
            return
        }
        var tag = ""
        if levels.contains(.verbose) {
            tag = "[🍏]"
        } else if levels.contains(.debug) {
            tag = "[⚙]"
        } else if levels.contains(.info) {
            tag = "[💚]"
        } else if levels.contains(.warn) {
            tag = "[⚠️]"
        } else if levels.contains(.error) {
            tag = "[❤️]"
        }
        print(YJLog.formatter.string(from: Date()), tag, log)
    }
    
    private static var formatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "zh-Hans-CN")
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss.SSS"
        return formatter
    }()
    
}
