//
//  NSObject+YJNSKVO.m
//  YJFoundation
//
//  HomePage:https://github.com/937447974/YJCocoa
//  YJ技术支持群:557445088
//
//  Created by 阳君 on 2017/12/13.
//  Copyright © 2016年 YJCocoa. All rights reserved.
//

#import "NSObject+YJNSKVO.h"
#import <objc/runtime.h>

@implementation NSObject (YJNSKVO)

- (void)addObserver:(NSObject *)observer forKeyPath:(NSString *)keyPath kvoBlock:(YJNSKVOBlock)kvoBlock {
    NSMutableDictionary *kvoDictionary = self.yj_kvoDictionary;
    NSMutableArray *kvoArray = [kvoDictionary objectForKey:keyPath];
    if (!kvoArray) {
        kvoArray = [NSMutableArray array];
        [kvoDictionary setObject:kvoArray forKey:keyPath];
    }
    YJNSKeyValueObserver *kvo = [[YJNSKeyValueObserver alloc] initWithObserver:observer forKeyPath:keyPath kvoBlock:kvoBlock];
    [kvoArray addObject:kvo];
    [self addObserver:kvo forKeyPath:keyPath options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld context:nil];
}

- (void)removeKVObserver:(NSObject *)observer forKeyPath:(NSString *)keyPath {
    NSMutableDictionary *kvoDictionary = self.yj_kvoDictionary;
    if (keyPath) {
        NSMutableArray *kvoArray = [kvoDictionary objectForKey:keyPath];
        kvoArray = [self yj_removeKVObserver:observer forKVOArray:kvoArray];
        [kvoDictionary setObject:kvoArray forKey:keyPath];
    } else {
        for (NSMutableArray<YJNSKeyValueObserver *> *kvoArray in kvoDictionary.allValues) {
            if (kvoArray.count) {
                keyPath = kvoArray.firstObject.keyPath;
                [kvoDictionary setObject:[self yj_removeKVObserver:observer forKVOArray:kvoArray] forKey:keyPath];
            }
        }
    }
}

- (NSMutableArray *)yj_removeKVObserver:(NSObject *)observer forKVOArray:(NSArray *)kvoArray {
    NSMutableArray *tempArray = [NSMutableArray array];
    for (YJNSKeyValueObserver *kvo in kvoArray) {
        if (!kvo.observer || kvo.observer == observer) {
            if (!kvo.removed) {
                kvo.removed = YES;
                [self removeObserver:kvo forKeyPath:kvo.keyPath];
            }
        } else {
            [tempArray addObject:kvo];
        }
    }
    return tempArray;
}

#pragma mark - getter
- (NSMutableDictionary *)yj_kvoDictionary {
    NSMutableDictionary *kvoDictionary = objc_getAssociatedObject(self, "yj_kvoDictionary");
    if (!kvoDictionary) {
        kvoDictionary = [NSMutableDictionary dictionary];
        objc_setAssociatedObject(self, "yj_kvoDictionary", kvoDictionary, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    return kvoDictionary;
}

@end
