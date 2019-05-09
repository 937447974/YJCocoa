//
//  YJNSSafetyDictionary.swift
//  YJCocoa
//
//  HomePage:https://github.com/937447974/YJCocoa
//  YJ技术支持群:557445088
//
//  Created by 阳君 on 2019/5/7.
//  Copyright © 2019年 YJCocoa. All rights reserved.
//

import UIKit

open class YJNSSafetyDictionary: NSMutableDictionary {
    
    private var dict = NSMutableDictionary()
    private var mutex = YJPthreadMutex()
    
}

//MARK: abstract class
extension YJNSSafetyDictionary {
    
    open override var count: Int {
        var count = 0
        self.mutex.lock {
            count = self.dict.count
        }
        return count
    }
    
    open override func keyEnumerator() -> NSEnumerator {
        var keyEnumerator: NSEnumerator!
        self.mutex.lock {
            keyEnumerator = self.dict.keyEnumerator()
        }
        return keyEnumerator
    }
    
    open override func object(forKey aKey: Any) -> Any? {
        var object: Any?
        self.mutex.lock {
            object = self.dict.object(forKey: aKey)
        }
        return object
    }
    
    open override func removeObject(forKey aKey: Any) {
        self.mutex.lock {
            self.dict.removeObject(forKey: aKey)
        }
    }
    
    open override func setObject(_ anObject: Any, forKey aKey: NSCopying) {
        self.mutex.lock {
            self.dict.setObject(anObject, forKey: aKey)
        }
    }
}

//MARK: aop
extension YJNSSafetyDictionary {
    
    open override func responds(to aSelector: Selector!) -> Bool {
        return self.dict.responds(to: aSelector)
    }
    
    open override func forwardingTarget(for aSelector: Selector!) -> Any? {
        return self.dict
    }
    
}
