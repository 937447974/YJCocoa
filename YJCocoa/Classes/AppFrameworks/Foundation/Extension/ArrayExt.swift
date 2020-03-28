//
//  ArrayExt.swift
//  YJCocoa
//
//  HomePage:https://github.com/937447974/YJCocoa
//  YJ技术支持群:557445088
//
//  Created by 阳君 on 2019/10/8.
//  Copyright © 2016-现在 YJCocoa. All rights reserved.
//

import UIKit

public extension Array where Element: Any {
    
    /// 按个数分割数组
    /// - parameter count: 每组的个数
    func split(count: Int) -> [[Element]] {
        guard self.count > count else {
            return [self]
        }
        var reslult = [[Element]]()
        var group = [Element]()
        for item in self {
            group.append(item)
            if group.count == count {
                reslult.append(group)
                group = [Element]()
            }
        }
        if group.count != 0 { reslult.append(group) }
        return reslult
    }
    
    /// 将数组转换为字典
    /// - parameter keySelector: 获取字典的key
    func groupBy<K>(_ keySelector: (Element) -> K) -> [K: [Element]] where K: Any{
        var result = [K: [Element]]()
        for item in self {
            let k = keySelector(item)
            var list = result[k] ?? [Element]()
            list.append(item)
            result[k] = list
        }
        return result
    }
    
}

public extension Array where Element == String {
    func object(at index: Int) -> Element {
        guard index < self.count else {
            return ""
        }
        return self[index]
    }
}

public extension Array where Element == Int {
    func object(at index: Int) -> Element {
        guard index < self.count else {
            return 0
        }
        return self[index]
    }
}
