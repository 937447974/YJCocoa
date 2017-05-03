//
//  UIViewController+YJUILayoutSupport.m
//  YJAutoLayout
//
//  HomePage:https://github.com/937447974/YJCocoa
//  YJ技术支持群:557445088
//
//  Created by 阳君 on 16/4/23.
//  Copyright © 2016年 YJCocoa. All rights reserved.
//

#import "UIViewController+YJUILayoutSupport.h"

@implementation UIViewController (YJUILayoutSupport)

#pragma mark - getter
- (YJUILayoutSupport *)topLayoutSupport {
    return [[YJUILayoutSupport alloc] initWithItem:self.topLayoutGuide];
}

- (YJUILayoutSupport *)bottomLayoutSupport {
    return [[YJUILayoutSupport alloc] initWithItem:self.bottomLayoutGuide];
}

@end
