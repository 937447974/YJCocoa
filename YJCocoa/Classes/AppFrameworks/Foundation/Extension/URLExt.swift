//
//  URLExt.swift
//  YJCocoa
//
//  HomePage:https://github.com/937447974/YJCocoa
//  YJ技术支持群:557445088
//
//  Created by 阳君 on 2019/8/1.
//  Copyright © 2016-现在 YJCocoa. All rights reserved.
//

import UIKit

public extension URL {
    
    /// http 中文链接utf8转码初始化
    static func utf8(_ string: String) -> URL? {
        guard let data = string.data(using: .utf8) else { return URL(string: string) }
        return URL(dataRepresentation: data, relativeTo: nil)
    }
    
    /// 文件类型
    var fileExtension: String? {
        guard self.pathExtension == "" else {
            return self.pathExtension
        }
        guard let data = try? Data(contentsOf: self) else {
            return nil
        }
        let bytes = [UInt8](data)
        guard bytes.count > 2 else {
            return nil
        }
        let extDict = ["255216" : "jpg", "13780" : "png", "7173" : "gif", "6677" : "bmp",
                       "8075":"zip", "8297":"rar",
                       "70105":"log", "102100":"txt"]
        return extDict["\(bytes[0])\(bytes[1])"]
    }
    
    /// 添加文件夹路径
    func appendingDirectory(_ pathComponent: String) -> URL {
        let url = self.appendingPathComponent(pathComponent, isDirectory: true)
        let fm = FileManager.default
        if !fm.directoryExists(atPath: url.path) {
            try? fm.createDirectory(at: url, withIntermediateDirectories: true, attributes: nil)
        }
        return url
    }
    
}
