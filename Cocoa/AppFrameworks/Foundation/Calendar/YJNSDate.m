//
//  YJNSDate.m
//  YJFoundation
//
//  HomePage:https://github.com/937447974/YJCocoa
//  YJ技术支持群:557445088
//
//  Created by 阳君 on 2017/1/5.
//  Copyright © 2017年 YJCocoa. All rights reserved.
//

#import "YJNSDate.h"

@implementation YJNSDate

- (instancetype)initWithSecond:(NSTimeInterval)second {
    self = [super init];
    if (self) {
        self.second = second;
    }
    return self;
}

@end
