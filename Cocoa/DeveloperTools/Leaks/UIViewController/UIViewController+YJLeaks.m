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

#if DEBUG

@implementation UIViewController (YJLeaks)

+ (void)startCaptureMemoryLeaks {
    [self swizzlingSEL:@selector(dismissViewControllerAnimated:completion:) withSEL:@selector(swizzlingLeaks_dismissViewControllerAnimated:completion:)];
}

- (void)swizzlingLeaks_dismissViewControllerAnimated:(BOOL)flag completion: (void (^ __nullable)(void))completion {
    [self captureMemoryLeaks];
    [self swizzlingLeaks_dismissViewControllerAnimated:flag completion:completion];
}

@end

#endif
