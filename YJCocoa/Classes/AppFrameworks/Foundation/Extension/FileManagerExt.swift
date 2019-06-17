//
//  FileManagerExt.swift
//  YJCocoa
//
//  Created by 阳君 on 2019/5/29.
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
    
}
