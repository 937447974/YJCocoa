//
//  UIView+YJLeaks.m
//  YJLeaks
//
//  HomePage:https://github.com/937447974/YJCocoa
//  YJ技术支持群:557445088
//
//  Created by 阳君 on 2017/1/12.
//  Copyright © 2017年 YJCocoa. All rights reserved.
//

#import "UIView+YJLeaks.h"
#import "YJSwizzling.h"

@implementation UIView (YJLeaks)

+ (void)start {
    [self swizzlingSEL:@selector(removeFromSuperview) withSEL:@selector(swizzling_removeFromSuperview)];
}

- (void)swizzling_removeFromSuperview {
    [self leaksCapture];
    [self swizzling_removeFromSuperview];
}

@end
