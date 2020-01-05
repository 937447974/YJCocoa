//
//  YJPthreadMutex.swift
//  YJCocoa
//
//  HomePage:https://github.com/937447974/YJCocoa
//  YJ技术支持群:557445088
//
//  Created by 阳君 on 2019/5/7.
//  Copyright © 2016-现在 YJCocoa. All rights reserved.
//

import Foundation

open class YJPthreadMutex: NSObject {
    
    private var mutex = pthread_mutex_t()
    
    public override init() {
        super.init()
        pthread_mutex_init(&mutex, nil)
    }
    
    deinit {
        pthread_mutex_destroy(&mutex)
    }
    
    public func lock(_ f: () -> Void) {
        _ = self.lockAny { () -> Any? in
            f()
            return nil
        }
    }
    
    public func lockObj<Object>(_ f: () throws -> Object) rethrows -> Object where Object : AnyObject {
        return try self.lockAny({ () -> Any? in
            return try f()
        }) as! Object
    }
    
    public func lockAny<Object>(_ f: () throws -> Object?) rethrows -> Object? where Object : Any {
        var finish = false
        var obj: Any?
        while !finish {
            if pthread_mutex_trylock(&mutex) == 0 {
                obj = try f()
                finish = true
                pthread_mutex_unlock(&mutex)
            } else {
                usleep(10 * 1000)
            }
        }
        return obj as? Object
    }
    
}
