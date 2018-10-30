//
//  AppDelegate.m
//  YJUINavigationRouter
//
//  Created by 阳君 on 2016/12/19.
//  Copyright © 2016年 YJCocoa. All rights reserved.
//

#import "AppDelegate.h"
#import "YJRouteHeader.h"

@interface AppDelegate () <YJNSURLRouterDelegate>

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    YJNSURLRouterS.delegate = self;
    return YES;
}

#pragma mark - YJNSURLRouterDelegate
- (BOOL)canOpenUnregisteredURL:(NSString *)url {
    return [url hasPrefix:@"http"]; // 网络跳转
}

- (void)openUnregisteredURL:(NSString *)url options:(nullable NSDictionary *)options completionHandler:(nullable dispatch_block_t)completion {
    // 做测试，直接转给 YJRouterURLMain
    [YJNSURLRouterS openURL:YJRouterURLMain options:options completionHandler:completion];
}

@end
