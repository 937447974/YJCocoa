//
//  YJLayoutSupport.m
//  YJAutoLayout
//
//  CSDN:http://blog.csdn.net/y550918116j
//  GitHub:https://github.com/937447974/Blog
//
//  Created by 阳君 on 16/4/23.
//  Copyright © 2016年 YJ. All rights reserved.
//

#import "YJLayoutSupport.h"

@implementation YJLayoutSupport

#pragma mark - super
- (instancetype)initWithItem:(id<UILayoutSupport>)layoutGuide {
    
    self = [super init];
    if (self) {
        _topLayout = [[YJLayoutYAxisAnchor alloc] initWithItem:layoutGuide attribute:NSLayoutAttributeTop];
        _bottomLayout = [[YJLayoutYAxisAnchor alloc] initWithItem:layoutGuide attribute:NSLayoutAttributeBottom];
    }
    return self;
    
}

@end
