//
//  YJSystemOther.h
//  YJCocoa
//
//  HomePage:https://github.com/937447974/YJCocoa
//  YJ技术支持群:557445088
//
//  Created by 阳君 on 2018/9/30.
//  Copyright © 2016年 YJCocoa. All rights reserved.
//

#ifndef YJSystemOther_h
#define YJSystemOther_h

#define SWIFT_SUBCLASS __attribute__((objc_subclassing_restricted))

#pragma mark - @符号

#define symbol_at try {} @catch (...) {}


#pragma mark - @finally_execute{}

#define cleanup_block void (^ cleanup_block_t)(void)
typedef cleanup_block;
static inline void executeCleanupBlock (__strong cleanup_block_t _Nonnull * _Nonnull block) {
    (*block)();
}

/**
 {
 @finally_execute {
 NSLog(@"finally_execute{}");
 };
 NSLog(@"finally_execute");
 }
 print "finally_execute \n finally_execute{}"
 */
#define finally_execute symbol_at __strong cleanup_block __attribute__((cleanup(executeCleanupBlock), unused)) = ^


#pragma mark - rac
/** 弱引用*/
#define weakSelf symbol_at  __weak typeof(self) wSelf = self;
/** 强引用*/
#define strongSelf symbol_at __strong typeof(wSelf) self = wSelf; if(!self) return;
/** 强引用,self不存在时，直接返回*/
#define strongSelfReturn(obj) symbol_at __strong typeof(wSelf) self = wSelf; if(!self) return obj;


#pragma mark - warning
/** 去掉 PerformSelector 警告*/
#define warningPerformSelector(function) \
symbol_at \
_Pragma("clang diagnostic push") \
_Pragma("clang diagnostic ignored \"-Warc-performSelector-leaks\"") \
function; \
_Pragma("clang diagnostic pop")

#endif /* YJSystemOther_h */
