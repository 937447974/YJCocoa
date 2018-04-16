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

+ (void)startCaptureMemoryLeaks {
    [self swizzlingSEL:@selector(popViewControllerAnimated:) withSEL:@selector(swizzlingLeaks_popViewControllerAnimated:)];
    [self swizzlingSEL:@selector(popToViewController:animated:) withSEL:@selector(swizzlingLeaks_popToViewController:animated:)];
    [self swizzlingSEL:@selector(popToRootViewControllerAnimated:) withSEL:@selector(swizzlingLeaks_popToRootViewControllerAnimated:)];
}

- (UIViewController *)swizzlingLeaks_popViewControllerAnimated:(BOOL)animated {
    [self.topViewController captureMemoryLeaks];
    return [self swizzlingLeaks_popViewControllerAnimated:animated];
}

- (nullable NSArray<__kindof UIViewController *> *)swizzlingLeaks_popToViewController:(UIViewController *)viewController animated:(BOOL)animated {
    [self.topViewController captureMemoryLeaks];
    return [self swizzlingLeaks_popToViewController:viewController animated:animated];
}

- (nullable NSArray<__kindof UIViewController *> *)swizzlingLeaks_popToRootViewControllerAnimated:(BOOL)animated {
    [self.topViewController captureMemoryLeaks];
    return [self swizzlingLeaks_popToRootViewControllerAnimated:animated];
}

@end

