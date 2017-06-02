//
//  YJLeaks.m
//  YJCocoa
//
//  HomePage:https://github.com/937447974/YJCocoa
//  YJ技术支持群:557445088
//
//  Created by 阳君 on 2017/1/12.
//  Copyright © 2017年 YJ. All rights reserved.
//

#import "YJLeaks.h"
#import "UINavigationController+YJLeaks.h"
#import "UIViewController+YJLeaks.h"
#import "UIView+YJLeaks.h"
#import "YJNSSingleton.h"

@implementation YJLeaks

+ (NSMutableSet<Class> *)ignoredClasses {
    return YJNSSingletonS(NSMutableSet, @"YJLeaks.ignoredClasses");
}

+ (void)start {
#if DEBUG
    [UINavigationController startCaptureMemoryLeaks];
    [UIViewController startCaptureMemoryLeaks];
    [UIView startCaptureMemoryLeaks];
#endif
}

@end
