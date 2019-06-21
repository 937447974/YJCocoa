//
//  AppDelegate.m
//  YJUINavigationRouter
//
//  Created by 阳君 on 2016/12/19.
//  Copyright © 2016年 YJCocoa. All rights reserved.
//

#import "AppDelegate.h"
#import "YJRouteHeader.h"
#import "YJMainViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    YJMainViewController *vc = [[YJMainViewController alloc] init];
    UINavigationBar.appearance.tintColor = UIColor.redColor;
    UINavigationController *nc = [[UINavigationController alloc] initWithRootViewController:vc];
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.window.backgroundColor = [UIColor whiteColor];
    self.window.rootViewController = nc;
    [self.window makeKeyAndVisible];
    
    YJNSLog.logLevel = YJLogLevelVerbose | YJLogLevelDebug | YJLogLevelInfo | YJLogLevelWarn | YJLogLevelError;
    [YJURLRouter.shared interceptUnregisteredWithCanOpen:^BOOL(NSString * url) {
        return [url hasPrefix:@"http"]; // 网络跳转
    } openHandler:^(NSString * url, NSDictionary<NSString *,id> * options, void (^ handler)(NSDictionary<NSString *,id> *)) {
        // 做测试，直接转给 YJRouterURLMain
        [YJURLRouter.shared openURLWithUrl:YJRouterURLMain options:options completion:handler];
    }];
    return YES;
}

@end
