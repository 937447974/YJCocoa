//
//  main.m
//  YJTimeProfiler
//
//  Created by admin on 2017/1/11.
//  Copyright © 2017年 YJCocoa. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import "YJNSSingleton.h"
#import "YJTimeProfiler.h"

/** 共享类*/

int main(int argc, char * argv[]) {
    @autoreleasepool {
        [YJTimePageProfiler start];
        YJNSSingletonS(YJTimeProfiler, nil).start = YES;
        return UIApplicationMain(argc, argv, nil, NSStringFromClass([AppDelegate class]));
    }
}
