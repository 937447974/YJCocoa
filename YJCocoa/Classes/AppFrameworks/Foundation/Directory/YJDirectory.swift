//
//  YJDirectory.swift
//  Pods
//
//  Created by 阳君 on 2019/5/27.
//

import UIKit

/// 应用内目录
@objcMembers
open class YJDirectory: NSObject {
    
    /// 应用内目录单例
    public static let shared = YJDirectory()
    
    /// HomeDirectoryPath
    public let homePath: String!
    /// DocumentDirectoryPath
    public let documentPath: String!
    /// LibraryDirectoryPath
    public let libraryPath: String!
    /// CachesDirectoryPath
    public let cachesPath: String!
    /// TemporaryDirectoryPath
    public let tempPath: String!
    
    /// HomeDirectoryURL
    public let homeURL: URL!
    /// DocumentDirectoryPath
    public let documentURL: URL!
    /// LibraryDirectoryPath
    public let libraryURL: URL!
    /// CachesDirectoryPath
    public let cachesURL: URL!
    /// TemporaryDirectoryPath
    public let tempURL: URL!
    
    public override init() {
        self.homePath = NSHomeDirectory()
        self.documentPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!
        self.libraryPath = NSSearchPathForDirectoriesInDomains(.libraryDirectory, .userDomainMask, true).first!
        self.cachesPath = NSSearchPathForDirectoriesInDomains(.cachesDirectory, .userDomainMask, true).first!
        self.tempPath = NSTemporaryDirectory()
        self.homeURL = URL(fileURLWithPath: self.homePath)
        self.documentURL = URL(fileURLWithPath: self.documentPath)
        self.libraryURL = URL(fileURLWithPath: self.libraryPath)
        self.cachesURL = URL(fileURLWithPath: self.cachesPath)
        self.tempURL = URL(fileURLWithPath: self.tempPath)
    }
    
}
