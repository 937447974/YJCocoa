//
//  TransformBasic.swift
//  YJCocoa
//
//  HomePage:https://github.com/937447974/YJCocoa
//  YJ技术支持群:557445088
//
//  Created by 阳君 on 2019/6/13.
//  Copyright © 2016-现在 YJCocoa. All rights reserved.
//

import UIKit

public extension YJJSONModelTransformBasic {
    static func transform(toJSON value: Any) -> Any? {
        return value
    }
}

extension Bool: YJJSONModelTransformBasic {
    public static func transform(fromJSON value: Any) -> Any? {
        if let str = value as? String {
            return str == "1" || str == "true"
        }
        return value as? Bool
    }
}

extension Int: YJJSONModelTransformBasic {
    public static func transform(fromJSON value: Any) -> Any? {
        if let str = value as? String {
            return Int(str)
        }
        return value as? Int
    }
}

extension Float: YJJSONModelTransformBasic {
    public static func transform(fromJSON value: Any) -> Any? {
        if let str = value as? String {
            return Float(str)
        }
        return value as? Float
    }
}

extension CGFloat: YJJSONModelTransformBasic {
    public static func transform(fromJSON value: Any) -> Any? {
        guard let float = Float.transform(toJSON: value) as? Float else {
            return nil
        }
        return CGFloat(float)
    }
}

extension Double: YJJSONModelTransformBasic {
    public static func transform(fromJSON value: Any) -> Any? {
        if let str = value as? String {
            return Double(str)
        }
        return value as? Double
    }
}

extension String: YJJSONModelTransformBasic {
    public static func transform(fromJSON value: Any) -> Any? {
        return "\(value)"
    }
}

extension Array: YJJSONModelTransformBasic where Element: YJJSONModelTransformBasic {
    
    public static func transform(fromJSON value: Any) -> Any? {
        guard let array = value as? [Any] else {
            return nil
        }
        var result = Array<Element>()
        for value in array {
            if let item = Element.transform(fromJSON: value) as? Element {
                result.append(item)
            }
        }
        return result
    }
    
    public static func transform(toJSON value: Any) -> Any? {
        guard let _value = value as? Array else {
            return nil
        }
        var result = Array<Any>()
        for item in _value {
            if let _item = Element.transform(toJSON: item) {
                result.append(_item)
            }
        }
        return result
    }
    
}

extension Optional: YJJSONModelTransformBasic where Wrapped: YJJSONModelTransformBasic {
    
    public static func transform(fromJSON value: Any) -> Any? {
        return Wrapped.transform(fromJSON: value)
    }
    
    public static func transform(toJSON value: Any) -> Any? {
        return Wrapped.transform(toJSON: value)
    }
    
}

extension URL: YJJSONModelTransformBasic {
    public static func transform(fromJSON value: Any) -> Any? {
        if let str = value as? String {
            return URL(string: str)
        }
        return value as? URL
    }
    
    public static func transform(toJSON value: Any) -> Any? {
        guard let url = value as? URL else {
            return nil
        }
        return "\(url)"
    }
}

extension Date: YJJSONModelTransformBasic {
    
    public static func transform(fromJSON value: Any) -> Any? {
        if let time = value as? TimeInterval {
            return Date(timeIntervalSince1970: time)
        }
        if let str = value as? String, let time = TimeInterval(str) {
            return Date(timeIntervalSince1970: time)
        }
        return value as? Date
    }
    
    public static func transform(toJSON value: Any) -> Any? {
        guard let _value = value as? Date else {
            return nil
        }
        return _value.timeIntervalSince1970
    }
    
}

extension UIColor: YJJSONModelTransformBasic {
    
    public static func transform(fromJSON value: Any) -> Any? {
        if let hex = value as? Int64 {
            if hex <= 0xFFFFFF {
                return UIColor(red: CGFloat((hex & 0xFF0000) >> 16)/255.0, green: CGFloat((hex & 0xFF00) >> 8)/255.0, blue: CGFloat(hex & 0xFF)/255.0, alpha: 1)
            } else {
                return UIColor(red: CGFloat((hex & 0xFF000000) >> 24)/255.0, green: CGFloat((hex & 0xFF0000) >> 16)/255.0, blue: CGFloat((hex & 0xFF00) >> 8)/255.0, alpha: CGFloat(hex & 0xFF)/255.0)
            }
        }
        return value as? UIColor
    }
    
    public static func transform(toJSON value: Any) -> Any? {
        guard let _value = value as? UIColor else {
            return nil
        }
        let comps = _value.cgColor.components!
        let r = Int(comps[0] * 255)
        let g = Int(comps[1] * 255)
        let b = Int(comps[2] * 255)
        let a = Int(comps[3] * 255)
        if a == 255 {
            return r << 16 + g << 8 + b
        } else {
            return r << 24 + g << 16 + b << 8 + a
        }
    }
    
}


