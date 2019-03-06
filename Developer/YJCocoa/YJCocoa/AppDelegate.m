//
//  AppDelegate.m
//  YJCocoa
//
//  Created by 阳君 on 16/5/16.
//  Copyright © 2016年 YJCocoa. All rights reserved.
//

#import "AppDelegate.h"
#import "ViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[UIWindow alloc] initWithFrame:UIScreen.mainScreen.bounds];
    self.window.backgroundColor = UIColor.whiteColor;
    self.window.rootViewController = [[ViewController alloc] init];
    [self.window makeKeyAndVisible];
    return YES;
}

@end
