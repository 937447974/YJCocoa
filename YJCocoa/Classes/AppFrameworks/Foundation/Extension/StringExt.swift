//
//  StringExt.swift
//  YJCocoa
//
//  HomePage:https://github.com/937447974/YJCocoa
//  YJ技术支持群:557445088
//
//  Created by 阳君 on 2019/5/29.
//  Copyright © 2016-现在 YJCocoa. All rights reserved.
//

import UIKit

public extension Optional where Wrapped == String {
    
    var isEmpty: Bool {
        get { return self?.isEmpty ?? true }
    }
    
}

public extension String {
    
    subscript(r: Range<Int>) -> String {
        guard r.upperBound <= self.count else { return "" }
        let start = self.index(self.startIndex, offsetBy: r.lowerBound)
        let end = self.index(self.startIndex, offsetBy: r.upperBound)
        return String(self[start..<end])
    }
    
    /// 移除前后空格
    func trimWhitespaces() -> String {
        return self.trimmingCharacters(in: .whitespaces)
    }
    
    /// 移除前后换行
    func trimNewlines() -> String {
        return self.trimmingCharacters(in: .newlines)
    }
    
    /// 字符串切割为数组
    func split(_ separator: Character) -> [String] {
        return self.split(separator: separator).map { String($0) }
    }
    
    /// 字符串替换
    func replacingOccurrences(of target: String, with replacement: String) -> String {
        return (self as NSString).replacingOccurrences(of: target, with: replacement)
    }
    
    /// 区间替换字符串
    func replacingCharacters(in range: NSRange, with replacement: String) -> String {
        return (self as NSString).replacingCharacters(in: range, with: replacement)
    }
    
    /// encode编码
    func encode() -> String {
        let characters = CharacterSet(charactersIn: ":/?#[]@!$ &'()*+,;=\"<>%{}|\\^~`").inverted
        return self.addingPercentEncoding(withAllowedCharacters: characters) ?? ""
    }
    
    /// decode解码
    func decode() -> String {
        return self.removingPercentEncoding ?? ""
    }
    
}
