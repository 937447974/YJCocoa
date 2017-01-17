//
//  UINavigationController+YJLeaks.m
//  YJLeaks
//
//  HomePage:https://github.com/937447974/YJCocoa
//  YJ技术支持群:557445088
//
//  Created by 阳君 on 2017/1/12.
//  Copyright © 2017年 YJCocoa. All rights reserved.
//

#import "UINavigationController+YJLeaks.h"
#import "YJSwizzling.h"
#import "UIViewController+YJLeaks.h"

@implementation UINavigationController (YJLeaks)

+ (void)start {
    [self swizzlingSEL:@selector(popViewControllerAnimated:) withSEL:@selector(swizzling_popViewControllerAnimated:)];
    [self swizzlingSEL:@selector(popToViewController:animated:) withSEL:@selector(swizzling_popToViewController:animated:)];
    [self swizzlingSEL:@selector(popToRootViewControllerAnimated:) withSEL:@selector(swizzling_popToRootViewControllerAnimated:)];
}

- (UIViewController *)swizzling_popViewControllerAnimated:(BOOL)animated {
    [self.topViewController captureMemoryLeaks];
    return [self swizzling_popViewControllerAnimated:animated];
}

- (nullable NSArray<__kindof UIViewController *> *)swizzling_popToViewController:(UIViewController *)viewController animated:(BOOL)animated {
    [self.topViewController captureMemoryLeaks];
    return [self swizzling_popToViewController:viewController animated:animated];
}

- (nullable NSArray<__kindof UIViewController *> *)swizzling_popToRootViewControllerAnimated:(BOOL)animated {
    [self.topViewController captureMemoryLeaks];
    return [self swizzling_popToRootViewControllerAnimated:animated];
}

@end
