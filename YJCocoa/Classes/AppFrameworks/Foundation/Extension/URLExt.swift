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
    
}
