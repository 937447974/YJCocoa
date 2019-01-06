//
//  AppDelegate.m
//  YJUINavigationRouter
//
//  Created by 阳君 on 2016/12/19.
//  Copyright © 2016年 YJCocoa. All rights reserved.
//

#import "AppDelegate.h"
#import "YJRouteHeader.h"
#import "YJNSLog.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    YJNSLog.logLevel = YJLogLevelVerbose | YJLogLevelDebug | YJLogLevelInfo | YJLogLevelWarn | YJLogLevelError;
    [YJNSURLRouterS interceptUnregisteredCanOpen:^BOOL(NSString *url) {
        return [url hasPrefix:@"http"]; // 网络跳转
    } openHandler:^(NSString *url, NSDictionary *options, YJRCompletionHandler handler) {
        // 做测试，直接转给 YJRouterURLMain
        [YJNSURLRouterS openURL:YJRouterURLMain options:options completionHandler:handler];
    }];
    return YES;
}

@end
