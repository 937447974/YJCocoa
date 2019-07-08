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
        guard let path = bundle.path(forResource: name, ofType: "bundle") else {
            return nil
        }
        return Bundle(path: path)
    }

}
