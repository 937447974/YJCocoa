//
//  AppDelegate.m
//  YJTimeline
//
//  Created by CISDI on 2019/1/19.
//  Copyright © 2019 YJCocoa. All rights reserved.
//

#import "AppDelegate.h"
#import <YJCocoa/YJTimeline.h>

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    [YJTimeline addSteps:@"didFinishLaunchingWithOptions"];
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    [YJTimeline addSteps:@"applicationWillResignActive"];
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    [YJTimeline addSteps:@"applicationDidEnterBackground"];
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    [YJTimeline addSteps:@"applicationWillEnterForeground"];
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    [YJTimeline addSteps:@"applicationDidBecomeActive"];
    [YJTimeline end];
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
