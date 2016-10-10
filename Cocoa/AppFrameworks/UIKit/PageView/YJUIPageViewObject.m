//
//  YJUIPageViewObject.m
//  YJUIPageView
//
//  HomePage:https://github.com/937447974/YJCocoa
//  YJ技术支持群:557445088
//
//  Created by 阳君 on 16/5/3.
//  Copyright © 2016年 YJCocoa. All rights reserved.
//

#import "YJUIPageViewObject.h"

@implementation YJUIPageViewObject

- (instancetype)initWithPageClass:(Class)pageClass {
    self = [super init];
    if (self) {
        _pageClass = pageClass;
    }
    return self;    
}

@end
