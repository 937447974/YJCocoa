//
//  YJSafetyDictionary.swift
//  YJCocoa
//
//  HomePage:https://github.com/937447974/YJCocoa
//  YJ技术支持群:557445088
//
//  Created by 阳君 on 2019/5/7.
//  Copyright © 2019年 YJCocoa. All rights reserved.
//

import Foundation

open class YJSafetyDictionary: NSMutableDictionary {
    
    private var dict = NSMutableDictionary()
    private var mutex = YJPthreadMutex()
    
}

//MARK: abstract class
extension YJSafetyDictionary {
    open override var count: Int {
        var count = 0
        self.mutex.lock {
            count = self.dict.count
        }
        return count
    }
    
    open override func keyEnumerator() -> NSEnumerator {
        return (self.mutex.lockObj {[unowned self] in
            self.dict.keyEnumerator()
        }) as! NSEnumerator
    }
    
    open override func object(forKey aKey: Any) -> Any? {
        return self.mutex.lockAny {[unowned self] in
            self.dict.object(forKey: aKey)
        }
    }
    
    open override func removeObject(forKey aKey: Any) {
        self.mutex.lock {[unowned self] in
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
extension YJSafetyDictionary {
    
    open override func responds(to aSelector: Selector!) -> Bool {
        return self.dict.responds(to: aSelector)
    }
    
    open override func forwardingTarget(for aSelector: Selector!) -> Any? {
        return self.dict
    }
    
}
