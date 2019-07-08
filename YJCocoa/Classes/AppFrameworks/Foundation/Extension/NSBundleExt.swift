//
//  NSBundleExt.swift
//  YJCocoa
//
//  Created by 阳君 on 2019/7/5.
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
