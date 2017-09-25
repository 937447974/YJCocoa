//
//  YJMainRouteManager.m
//  YJUINavigationRouter
//
//  Created by 阳君 on 2016/12/20.
//  Copyright © 2016年 YJCocoa. All rights reserved.
//

#import "YJMainRouteManager.h"
#import "YJMainViewController.h"

YJNSRouterURL const YJRouterURLMain = @"YJRouterURLMain";

@implementation YJMainRouteManager

+ (void)setup {
    [YJNSRouteManagerS registerRouter:[YJMainViewController class] forURL:YJRouterURLMain];
}

@end
