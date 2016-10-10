//
//  YJNSPerformSelector.m
//  YJFoundation
//
//  HomePage:https://github.com/937447974/YJCocoa
//  YJ技术支持群:557445088
//
//  Created by 阳君 on 16/7/25.
//  Copyright © 2016年 YJCocoa. All rights reserved.
//

#import "YJNSPerformSelector.h"

@implementation YJNSPerformSelector

- (instancetype)initWithSuccess:(BOOL)success result:(id)result {
    self = [super init];
    if (self) {
        self.success = success;
        self.result = result;
    }
    return self;
}

@end
