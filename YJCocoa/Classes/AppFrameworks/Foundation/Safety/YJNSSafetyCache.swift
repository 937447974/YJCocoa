//
//  YJNSSafetyCache.swift
//  YJCocoa
//
//  HomePage:https://github.com/937447974/YJCocoa
//  YJ技术支持群:557445088
//
//  Created by 阳君 on 2019/5/6.
//  Copyright © 2019年 YJCocoa. All rights reserved.
//

import Foundation

/// 线程安全的NSCache
open class YJNSSafetyCache<KeyType, ObjectType> : NSCache<AnyObject, AnyObject> where KeyType : AnyObject, ObjectType : AnyObject {
    
    /// 所有 key
    open var allKeys: Array<KeyType> {
        return self.cacheSet.allObjects as! Array<KeyType>
    }
    /// 所有 value
    open var allValues: Array<KeyType> {
        var array = Array<AnyObject>()
        for key: KeyType in self.allKeys {
            if let obj = self.object(forKey: key) {
                array.append(obj)
            }
        }
        return array as! Array<KeyType>
    }
    /// 总数
    open var count: Int {
        return self.allKeys.count
    }
    
    private var cacheSet = NSMutableSet()
    private var mutex = YJPthreadMutex()
    
    // MARK: - Super
    open func object(forKey key: KeyType) -> ObjectType? {
        var obj: ObjectType?
        self.mutex.lock {
            obj = super.object(forKey: key) as? ObjectType
            if obj == nil {
                self.cacheSet.remove(key)
            }
        }
        return obj
    }
    
    open func setObject(_ obj: ObjectType, forKey key: KeyType) {
        self.mutex.lock {
            super.setObject(obj, forKey: key)
            self.cacheSet.add(key)
        }
    }
    
    open func setObject(_ obj: ObjectType, forKey key: KeyType, cost g: Int) {
        self.mutex.lock {
            super.setObject(obj, forKey: key, cost: g)
            self.cacheSet.add(key)
        }
    }
    
    open func removeObject(forKey key: KeyType) {
        self.mutex.lock {
            super.removeObject(forKey: key)
            self.cacheSet.remove(key)
        }
    }
    
    open override func removeAllObjects() {
        self.mutex.lock {
            super.removeAllObjects()
            self.cacheSet.removeAllObjects()
        }
    }
    
}
