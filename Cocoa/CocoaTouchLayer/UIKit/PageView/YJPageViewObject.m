//
//  YJPageViewObject.m
//  YJPageView
//
//  HomePage:https://github.com/937447974/YJCocoa
//  YJ技术支持群:557445088
//
//  Created by 阳君 on 16/5/3.
//  Copyright © 2016年 YJ. All rights reserved.
//

#import "YJPageViewObject.h"

@implementation YJPageViewObject

- (instancetype)initWithPageClass:(Class)pageClass {
    self = [super init];
    if (self) {
        _pageClass = pageClass;
    }
    return self;    
}

@end
