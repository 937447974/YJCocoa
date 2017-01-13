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
    NSLog(@"----%@", self);
    [self swizzling_removeFromSuperview];
    
}

- (void)leaksCapture {
    NSString *className = NSStringFromClass(self.class);
    if ([className hasPrefix:@"UI"] || [className hasPrefix:@"_"]) {
        return;
    }
    NSPointerArray *subviews = [NSPointerArray weakObjectsPointerArray];
    __weakSelf
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^{
        if (weakSelf) {
            [subviews compact];
            NSLog(@"\nYJLeaks捕获内存泄漏\nUIViewController:%@\nsubviews:%@", className, subviews.allObjects);
        }
    });
}

@end
