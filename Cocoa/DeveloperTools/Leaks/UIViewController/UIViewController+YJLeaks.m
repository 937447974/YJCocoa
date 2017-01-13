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

@implementation UIViewController (YJLeaks)

+ (void)start {
    [self swizzlingSEL:@selector(dismissViewControllerAnimated:completion:) withSEL:@selector(swizzling_dismissViewControllerAnimated:completion:)];
}

- (void)swizzling_dismissViewControllerAnimated:(BOOL)flag completion: (void (^ __nullable)(void))completion {
    [self leaksCapture];
    [self swizzling_dismissViewControllerAnimated:flag completion:completion];    
}

@end
