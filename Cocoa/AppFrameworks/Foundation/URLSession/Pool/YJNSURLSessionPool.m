//
//  YJNSURLSessionPool.m
//  YJFoundation
//
//  HomePage:https://github.com/937447974/YJCocoa
//  YJ技术支持群:557445088
//
//  Created by 阳君 on 2016/11/30.
//  Copyright © 2016年 YJCocoa. All rights reserved.
//

#import "YJNSURLSessionPool.h"
#import "YJNSSingletonMCenter.h"

@implementation YJNSURLSessionPool

+ (YJNSURLSessionPool *)sharedPool {
    return [YJNSSingletonMC registerStrongSingleton:self.class];
}

- (instancetype)init {
    self = [super init];
    if (self) {
        self.poolDict = [NSMutableDictionary dictionary];
    }
    return self;
}

@end
