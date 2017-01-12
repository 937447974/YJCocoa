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
    
}

- (void)swizzling_removeFromSuperview {
    [self removeFromSuperview];
}

- (void)allSubview:(UIView *)view toLeaks:(NSPointerArray *)subviews {
    NSString *className;
    for (UIView *subview in view.subviews) {
        className = NSStringFromClass(subview.class);
        if ([className hasPrefix:@"UI"] || [className hasPrefix:@"_"]) {
            continue;
        }
        [subviews addPointer:(__bridge void * _Nullable)(subview)];
    }
}

@end
