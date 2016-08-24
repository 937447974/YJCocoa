//
//  UIViewController+YJTLayoutSupport.m
//  YJAutoLayout
//
//  HomePage:https://github.com/937447974/YJCocoa
//  YJ技术支持群:557445088
//
//  Created by 阳君 on 16/4/23.
//  Copyright © 2016年 YJCocoa. All rights reserved.
//

#import "UIViewController+YJTLayoutSupport.h"

@implementation UIViewController (YJTLayoutSupport)

#pragma mark - getter
- (YJTLayoutSupport *)topLayoutSupport {
    return [[YJTLayoutSupport alloc] initWithItem:self.topLayoutGuide];
}

- (YJTLayoutSupport *)bottomLayoutSupport {
    return [[YJTLayoutSupport alloc] initWithItem:self.bottomLayoutGuide];
}

@end
