//
//  UIViewController+YJLayoutSupport.m
//  YJAutoLayout
//
//  CSDN:http://blog.csdn.net/y550918116j
//  GitHub:https://github.com/937447974/Blog
//
//  Created by 阳君 on 16/4/23.
//  Copyright © 2016年 YJ. All rights reserved.
//

#import "UIViewController+YJLayoutSupport.h"

@implementation UIViewController (YJLayoutSupport)

#pragma mark - getter
- (YJLayoutSupport *)topLayoutSupport {
    return [[YJLayoutSupport alloc] initWithItem:self.topLayoutGuide];
}

- (YJLayoutSupport *)bottomLayoutSupport {
    return [[YJLayoutSupport alloc] initWithItem:self.bottomLayoutGuide];    
}

@end
