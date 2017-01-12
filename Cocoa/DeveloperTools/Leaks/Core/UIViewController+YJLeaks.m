//
//  UIViewController+YJLeaks.m
//  YJLeaks
//
//  HomePage:https://github.com/937447974/YJCocoa
//  YJ技术支持群:557445088
//
//  Created by 阳君 on 2017/1/12.
//  Copyright © 2017年 YJCocoa. All rights reserved.
//

#import "UIViewController+YJLeaks.h"
#import "YJSwizzling.h"
#import "UIView+YJLeaks.h"
#import "YJDispatch.h"

@implementation UIViewController (YJLeaks)

+ (void)start {
    [self swizzlingSEL:@selector(dismissViewControllerAnimated:completion:) withSEL:@selector(swizzling_dismissViewControllerAnimated:completion:)];
}

- (void)swizzling_dismissViewControllerAnimated:(BOOL)flag completion: (void (^ __nullable)(void))completion {
    [self swizzling_dismissViewControllerAnimated:flag completion:completion];
    [self leaksCapture];
}

- (void)leaksCapture {
    NSString *className = NSStringFromClass(self.class);
    if ([className hasPrefix:@"UI"] || [className hasPrefix:@"_"]) {
        return;
    }
    NSPointerArray *subviews = [NSPointerArray weakObjectsPointerArray];
    [self.view allSubview:self.view toLeaks:subviews];
    __weakSelf
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^{
        if (weakSelf) {
            [subviews compact];
            NSLog(@"\nYJLeaks捕获内存泄漏\nUIViewController:%@\nsubviews:%@", className, subviews.allObjects);
        }
    });
}

@end
