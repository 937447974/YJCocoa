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

public extension Optional where Wrapped == Array<Any> {
    /// 判断数组是否为空
    var isEmpty: Bool {
        get { return self?.isEmpty ?? true }
    }
}

public extension Array where Element: Any {
    
    /// 数据提取
    /// - parameter index: 索引位置
    func object(at index: Int) -> Element? {
        guard index < self.count else { return nil }
        return self[index]
    }
    
    /// 按照key分组
    /// - parameter keySelector: 获取字典的key
    func groupBy<K>(_ keySelector: (Element) -> K) -> [K: [Element]] where K: Any {
        var result = [K: [Element]]()
        for item in self {
            let k = keySelector(item)
            var list = result[k] ?? [Element]()
            list.append(item)
            result[k] = list
        }
        return result
    }
    
    /// 转换为数组
    /// - parameter transform: 转换器
    func map<T>(_ transform: (Element) throws -> T?) rethrows -> [T] {
        let mapArray: [T?] = try self.map(transform)
        let filterArray: [T?] = mapArray.filter {  $0 != nil }
        return filterArray.map{$0!}
    }
    
    /// 转换为字典
    /// - parameter keyTransform: key转换器
    /// - parameter valueTransform: value转换器
    func map<K, V>(_ keyTransform: (Element) throws -> K?, valueTransform: (Element) throws -> V? = {$0 as? V}) rethrows -> [K:V] {
        var result = [K:V]()
        for item in self {
            if let key = try keyTransform(item) {
                result[key] = try valueTransform(item)
            }
        }
        return result
    }
    
    /// 获取去重数组
    func distinct() -> [Element] where Element: Equatable {
        var result = [Element]()
        for item in self {
            if !result.contains(where: {$0 == item}) {
                result.append(item)
            }
        }
        return result
    }
    
}

