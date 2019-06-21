//
//  YJURLRouterLoad.m
//  YJURLRouter
//
//  Created by 阳君 on 2019/6/4.
//  Copyright © 2019 YJCocoa. All rights reserved.
//

#import "YJURLRouterLoad.h"
#import <YJCocoa/YJCocoa-Swift.h>
#import <YJCocoa/YJCocoa-umbrella.h>
#import "YJMainViewController.h"
#import "YJOtherViewController.h"

@implementation YJURLRouterLoad

YJURLROUTER_LOAD(^{
    YJURLRouter *router = YJURLRouter.shared;
    [router registerWithUrl:YJRouterURLMain cls:YJMainViewController.class cache:YES];
    [router registerWithUrl:YJRouterURLOther handler:^(NSString * url, NSDictionary<NSString *,id> * options, void (^ handler)(NSDictionary<NSString *,id> * _Nonnull)) {
        YJOtherViewController *vc = YJOtherViewController.new;
        [vc routerReloadDataWith:options completion:handler];
        [vc routerOpen];
    }];
})

@end
