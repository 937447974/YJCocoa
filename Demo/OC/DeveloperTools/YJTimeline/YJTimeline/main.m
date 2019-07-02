//
//  main.m
//  YJTimeline
//
//  Created by CISDI on 2019/1/19.
//  Copyright © 2019 YJCocoa. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import <YJCocoa/YJCocoa-Swift.h>

int main(int argc, char * argv[]) {
    @autoreleasepool {
        [YJTimeline addWithStep:@"main"];
        return UIApplicationMain(argc, argv, nil, NSStringFromClass([AppDelegate class]));
    }
}
