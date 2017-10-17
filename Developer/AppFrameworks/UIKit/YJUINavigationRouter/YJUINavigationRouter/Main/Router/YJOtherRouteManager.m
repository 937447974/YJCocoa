//
//  YJOtherRouteManager.m
//  YJUINavigationRouter
//
//  Created by 阳君 on 2016/12/20.
//  Copyright © 2016年 YJCocoa. All rights reserved.
//

#import "YJOtherRouteManager.h"
#import "YJOtherViewController.h"

YJNSRouterURL const YJRouterURLOther = @"YJRouterURLOther"; ///< 其他

@implementation YJOtherRouteManager

+ (void)setup {
    [YJNSRouteManagerS registerRouterNode:[YJNSRouterNode nodeWithRouterClass:YJOtherViewController.class scope:nil routerURL:YJRouterURLOther]];
}

@end
