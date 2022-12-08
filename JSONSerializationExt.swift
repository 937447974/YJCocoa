//
//  JSONSerializationExt.swift
//  YJCocoa
//
//  HomePage:https://github.com/937447974/YJCocoa
//  YJ技术支持群:557445088
//
//  Created by 阳君 on 2022/12/8.
//  Copyright © 2016-现在 YJCocoa. All rights reserved.
//

import Foundation

public extension JSONSerialization {
    
    /// Generate JSON from a Foundation object
    class func jsonString(with obj: Any, options opt: JSONSerialization.WritingOptions = []) throws -> String? {
        let jsonData = try self.data(withJSONObject: obj, options: opt)
        return String(data: jsonData, encoding: .utf8)
    }
    
    /// Create a Foundation object from JSON
    class func jsonObject(with json: String, options opt: JSONSerialization.ReadingOptions = .allowFragments) throws -> Any? {
        guard let data = json.data(using: String.Encoding.utf8) else {
            return nil
        }
        return try self.jsonObject(with: data, options: opt)
    }
    
}
