//
//  FileManagerExt.swift
//  YJCocoa
//
//  HomePage:https://github.com/937447974/YJCocoa
//  YJ技术支持群:557445088
//
//  Created by 阳君 on 2019/5/29.
//  Copyright © 2016-现在 YJCocoa. All rights reserved.
//

import UIKit

extension FileManager {
    
    /// 安全的移动文件
    /// - parameter fromePath: 源地址
    /// - parameter toPath:   目标地址
    open func moveItem(fromePath: String, toPath: String) throws {
        try self.moveItem(fromURL: URL(fileURLWithPath: fromePath) , toURL: URL(fileURLWithPath: toPath))
    }
    
    /// 安全的移动文件
    /// - parameter fromURL: 源地址
    /// - parameter toURL:   目标地址
    open func moveItem(fromURL: URL, toURL: URL) throws {
        guard fromURL != toURL else {
            return
        }
        let toDirectory = toURL.deletingLastPathComponent()
        if self.fileExists(atPath: toDirectory.path) {
            if self.fileExists(atPath: toURL.path) {
                try self.removeItem(at: toURL)
            }
        } else {
            try self.createDirectory(at: toDirectory, withIntermediateDirectories: true, attributes: nil)
        }
        try self.moveItem(at: fromURL, to: toURL)
    }
    
    /// 是否存在文件夹
    open func directoryExists(atPath path: String) -> Bool {
        let fm = FileManager.default
        var isDirectory = ObjCBool.init(false)
        let exists = fm.fileExists(atPath: path, isDirectory: &isDirectory)
        return exists && isDirectory.boolValue
    }
    
}

@objcMembers
open class YJFileManager: NSObject {
    
    public static func moveItem(fromePath: String, toPath: String) throws {
        try FileManager.default.moveItem(fromePath: fromePath, toPath: toPath)
    }
    
    public static func moveItem(fromURL: URL, toURL: URL) throws {
        try FileManager.default.moveItem(fromURL: fromURL, toURL: toURL)
    }
    
}
