//
//  NSBundleExt.swift
//  YJCocoa
//
//  HomePage:https://github.com/937447974/YJCocoa
//  YJ技术支持群:557445088
//
//  Created by 阳君 on 2019/7/5.
//  Copyright © 2016-现在 YJCocoa. All rights reserved.
//

import UIKit

public extension Bundle {
    
    /// 根据 framework 中的 bundle 名和class 生成 Bundle
    /// - parameter name:   framework 中的 bundle 名
    /// - parameter aClass: framework 中的某个 class 名
    static func budle(whit name: String, for aClass: AnyClass) -> Bundle? {
        let bundle = Bundle(for: aClass)
        return bundle.budle(forResource: name, ofType: "bundle")
    }
    
    /// 替换 path(forResource name: String?, ofType ext: String?) 直接生成 Bundle
    func budle(forResource name: String, ofType ext: String) -> Bundle? {
        guard let path = self.path(forResource: name, ofType: ext) else {
            return nil
        }
        return Bundle(path: path)
    }

}
