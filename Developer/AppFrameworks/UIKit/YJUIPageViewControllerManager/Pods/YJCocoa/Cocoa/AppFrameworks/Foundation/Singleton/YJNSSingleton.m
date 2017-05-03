//
//  YJNSSingleton.m
//  YJCocoa
//
//  HomePage:https://github.com/937447974/YJCocoa
//  YJ技术支持群:557445088
//
//  Created by 阳君 on 2017/3/14.
//  Copyright © 2017年 YJ. All rights reserved.
//

#import "YJNSSingleton.h"

@implementation NSObject (YJNSSingleton)

+ (instancetype)strongSingleton:(NSString *)identifier {
    return [YJNSSingletonMC registerStrongSingleton:[self class] forIdentifier:identifier];
}

+ (instancetype)weakSingleton:(NSString *)identifier {
    return [YJNSSingletonMC registerWeakSingleton:[self class] forIdentifier:identifier];
}

@end
