//
//  YJNSWeakObject.m
//  YJCocoa
//
//  HomePage:https://github.com/937447974/YJCocoa
//  YJ技术支持群:557445088
//
//
//  Created by 阳君 on 2018/10/18.
//  Copyright © 2016年 YJCocoa. All rights reserved.
//

#import "YJNSWeakObject.h"

@implementation YJNSWeakObject

- (instancetype)initWithObject:(id)object {
    self = [super init];
    if (self) {
        self.object = object;
    }
    return self;
}

@end
