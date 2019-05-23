//
//  YJPthreadMutex.swift
//  Pods
//
//  Created by 阳君 on 2019/5/7.
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
        pthread_mutex_lock(&mutex)
        f()
        pthread_mutex_unlock(&mutex)
    }
    
    public func lockObj(_ f: () -> AnyObject) -> AnyObject {
        pthread_mutex_lock(&mutex)
        let obj = f()
        pthread_mutex_unlock(&mutex)
        return obj
    }
    
    public func lockAny(_ f: () -> Any?) -> Any? {
        pthread_mutex_lock(&mutex)
        let obj = f()
        pthread_mutex_unlock(&mutex)
        return obj
    }
    
}
