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

#if DEBUG

@implementation UIView (YJLeaks)

+ (void)startCaptureMemoryLeaks {
    [self swizzlingSEL:@selector(removeFromSuperview) withSEL:@selector(swizzling_removeFromSuperview)];
}

- (void)swizzling_removeFromSuperview {
    [self captureMemoryLeaks];
    [self swizzling_removeFromSuperview];
}

@end

#endif
