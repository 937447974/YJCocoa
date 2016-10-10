//
//  YJNSLayoutSupport.m
//  YJAutoLayout
//
//  HomePage:https://github.com/937447974/YJCocoa
//  YJ技术支持群:557445088
//
//  Created by 阳君 on 16/4/23.
//  Copyright © 2016年 YJCocoa. All rights reserved.
//

#import "YJUILayoutSupport.h"

@implementation YJUILayoutSupport

#pragma mark - super
- (instancetype)initWithItem:(id<UILayoutSupport>)layoutGuide {    
    self = [super init];
    if (self) {
        _topLayout = [[YJNSLayoutYAxisAnchor alloc] initWithItem:layoutGuide attribute:NSLayoutAttributeTop];
        _bottomLayout = [[YJNSLayoutYAxisAnchor alloc] initWithItem:layoutGuide attribute:NSLayoutAttributeBottom];
    }
    return self;
    
}

@end
