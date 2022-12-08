//
//  NSDictionary+YJSafety.swift
//  YJCocoa
//
//  HomePage:https://github.com/937447974/YJCocoa
//  YJ技术支持群:557445088
//
//  Created by 阳君 on 2019/5/8.
//  Copyright © 2016-现在 YJCocoa. All rights reserved.
//

import Foundation

public extension NSDictionary {
    
    func bool(forKey key: Any) -> Bool {
        guard let obj = self.object(forKey: key) else {
            return false
        }
        if obj is NSNumber {
            return (obj as! NSNumber).boolValue
        }
        if obj is NSString {
            return (obj as! NSString).boolValue
        }
        return false
    }
    
    func integer(forKey key: Any) -> Int {
        guard let obj = self.object(forKey: key) else {
            return 0
        }
        if obj is NSNumber {
            return (obj as! NSNumber).intValue
        }
        if obj is NSString {
            return (obj as! NSString).integerValue
        }
        return 0
    }
    
    func float(forKey key: Any) -> Float {
        guard let obj = self.object(forKey: key) else {
            return 0.0
        }
        if obj is NSNumber {
            return (obj as! NSNumber).floatValue
        }
        if obj is NSString {
            return (obj as! NSString).floatValue
        }
        return 0.0
    }
    
    func string(forKey key: Any) -> String {
        guard let obj = self.object(forKey: key) else {
            return ""
        }
        if obj is NSNumber {
            return (obj as! NSNumber).stringValue
        }
        if obj is NSString {
            return obj as! String
        }
        return ""
    }
    
    func set(forKey key: Any) -> NSSet {
        guard let obj = self.object(forKey: key) else {
            return NSSet()
        }
        if obj is NSSet {
            return obj as! NSSet
        }
        return NSSet()
    }
    
    func array(forKey key: Any) -> NSArray {
        guard let obj = self.object(forKey: key) else {
            return NSArray()
        }
        if obj is NSArray {
            return obj as! NSArray
        }
        return NSArray()
    }
    
    func dictionary(forKey key: Any) -> NSDictionary {
        guard let obj = self.object(forKey: key) else {
            return NSDictionary()
        }
        if obj is NSDictionary {
            return obj as! NSDictionary
        }
        return NSDictionary()
    }
    
}


public extension NSMutableDictionary {
    
    func mutableSet(forKey key: Any) -> NSMutableSet {
        var obj = self.object(forKey: key)
        if obj is NSMutableSet {
            return obj as! NSMutableSet
        } else if obj is NSSet {
            obj = (obj as! NSSet).mutableCopy()
        } else {
            obj = NSMutableSet()
        }
        self.setObject(obj!, forKey: key as! NSCopying)
        return obj as! NSMutableSet
    }
    
    func mutableArray(forKey key: Any) -> NSMutableArray {
        var obj = self.object(forKey: key)
        if obj is NSMutableArray {
            return obj as! NSMutableArray
        } else if obj is NSArray {
            obj = (obj as! NSArray).mutableCopy()
        } else {
            obj = NSMutableArray()
        }
        self.setArray(obj!, forKey: key as! NSCopying)
        return obj as! NSMutableArray
    }
    
    func mutableDictionary(forKey key: Any) -> NSMutableDictionary {
        var obj = self.object(forKey: key)
        if obj is NSMutableDictionary {
            return obj as! NSMutableDictionary
        } else if obj is NSDictionary {
            obj = (obj as! NSDictionary).mutableCopy()
        } else {
            obj = NSMutableDictionary()
        }
        self.setObject(obj!, forKey: key as! NSCopying)
        return obj as! NSMutableDictionary
    }
    
    func setBool(_ anObject: Bool, forKey aKey: NSCopying) {
        self.setObject(anObject, forKey: aKey)
    }
    
    func setInt(_ anObject: Int, forKey aKey: NSCopying) {
        self.setObject(anObject, forKey: aKey)
    }
    
    func setFloat(_ anObject: Float, forKey aKey: NSCopying) {
        self.setObject(anObject, forKey: aKey)
    }
    
    func setString(_ anObject: Any, forKey aKey: NSCopying) {
        guard let obj = anObject as? NSString else {
            YJLogError("[Dictionary] set key:\(aKey) 对应的 value:\(anObject) 错误")
            return
        }
        self.setObject(obj, forKey: aKey)
    }
    
    func setSet(_ anObject: Any, forKey aKey: NSCopying) {
        guard let obj = anObject as? NSSet else {
            YJLogError("[Dictionary] set key:\(aKey) 对应的 value:\(anObject) 错误")
            return
        }
        self.setObject(obj, forKey: aKey)
    }
    
    func setArray(_ anObject: Any, forKey aKey: NSCopying) {
        guard let obj = anObject as? NSArray else {
            YJLogError("[Dictionary] set key:\(aKey) 对应的 value:\(anObject) 错误")
            return
        }
        self.setObject(obj, forKey: aKey)
    }
    
    func setDictionary(_ anObject: Any, forKey aKey: NSCopying) {
        guard let obj = anObject as? NSDictionary else {
            YJLogError("[Dictionary] set key:\(aKey) 对应的 value:\(anObject) 错误")
            return
        }
        self.setObject(obj, forKey: aKey)
    }
    
}
