//
//  YJPthread.h
//  YJCocoa
//
//  HomePage:https://github.com/937447974/YJCocoa
//  YJ技术支持群:557445088
//
//  Created by 阳君 on 2018/9/30.
//  Copyright © 2016年 YJCocoa. All rights reserved.
//

#ifndef YJPthread_h
#define YJPthread_h

#import <pthread.h>

/**
 pthread_mutex_t _lock;            //1. @interface内属性
 pthread_mutex_init(&_lock, NULL); //2. init
 {                                 //3. {}内加锁
 @synchronized_pthread (_lock)
 }
 pthread_mutex_destroy(&_lock);    //4. dealloc
 */
#define synchronized_pthread(lock) \
symbol_at \
pthread_mutex_lock(&lock); @finally_execute { pthread_mutex_unlock(&lock); };

/**
 @synchronized_pthread_try(_lock) { //1. 🔐成功
 } @synchronized_pthread_try_else { //2. 🔐失败
 } @synchronized_pthread_try_end    //3. 🔐结束
 */
#define synchronized_pthread_try(lock)  symbol_at if (pthread_mutex_trylock(&lock) == 0) {\
@finally_execute { pthread_mutex_unlock(&lock); };
#define synchronized_pthread_try_else   symbol_at } else {
#define synchronized_pthread_try_end    symbol_at }

#endif /* YJPthread_h */
