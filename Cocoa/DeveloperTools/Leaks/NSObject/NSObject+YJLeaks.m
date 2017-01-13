//
//  NSObject+YJLeaks.m
//  YJLeaks
//
//  HomePage:https://github.com/937447974/YJCocoa
//  YJ技术支持群:557445088
//
//  Created by 阳君 on 2017/1/13.
//  Copyright © 2017年 YJCocoa. All rights reserved.
//

#import "NSObject+YJLeaks.h"

@implementation NSObject (YJLeaks)

+ (void)start {
    [self doesNotRecognizeSelector:_cmd];
}

- (void)leaksCapture {
    NSString *className = NSStringFromClass(self.class);
    if ([className hasPrefix:@"UI"] || [className hasPrefix:@"NS"] || [className hasPrefix:@"_"]) {
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
