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
    [self swizzlingSEL:@selector(removeFromSuperview) withSEL:@selector(swizzlingLeaks_removeFromSuperview)];
}

- (void)swizzlingLeaks_removeFromSuperview {
    [self captureMemoryLeaks];
    [self swizzlingLeaks_removeFromSuperview];
}

@end

#endif
