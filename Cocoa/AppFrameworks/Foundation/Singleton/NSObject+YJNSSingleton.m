//
//  NSObject+YJNSSingleton.m
//  YJFoundation
//
//  Created by 阳君 on 2017/3/13.
//  Copyright © 2017年 YJCocoa. All rights reserved.
//

#import "NSObject+YJNSSingleton.h"

@implementation NSObject (YJNSSingleton)

+ (instancetype)strongSingleton {
    return [YJNSSingletonMC registerStrongSingleton:[self class]];
}

+ (instancetype)weakSingleton {
    return [YJNSSingletonMC registerWeakSingleton:[self class]];
}

@end
