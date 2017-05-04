//
//  YJUIPageViewCellObject.m
//  PageViewManager
//
//  HomePage:https://github.com/937447974/YJCocoa
//  YJ技术支持群:557445088
//
//  Created by 阳君 on 2017/2/9.
//  Copyright © 2017年 YJ. All rights reserved.
//

#import "YJUIPageViewCellObject.h"

@implementation YJUIPageViewCellObject

- (instancetype)initWithPageClass:(Class)pageClass {
    self = [super init];
    if (self) {
        _pageClass = pageClass;
    }
    return self;
}

@end
