//
//  YJTimeline.m
//  YJCocoa
//
//  HomePage:https://github.com/937447974/YJCocoa
//  YJ技术支持群:557445088
//
//  Created by 阳君 on 2019/1/19.
//  Copyright © 2016年 YJCocoa. All rights reserved.
//

#import "YJTimeline.h"
#import "YJNSLog.h"

@implementation YJTimeline
static NSMutableString *YJTimeline_log;
CFAbsoluteTime YJTimeline_time;

+ (void)addSteps:(NSString *)steps {
    if (!YJTimeline_log) YJTimeline_log = NSMutableString.string;
    CFAbsoluteTime currentTime = CFAbsoluteTimeGetCurrent();
    CFAbsoluteTime timeInterval = currentTime - YJTimeline_time;
    YJTimeline_time = currentTime;
    if (YJTimeline_log.length) [YJTimeline_log appendFormat:@" %f", timeInterval];
    [YJTimeline_log appendFormat:@"\n\t%@", steps];
}

+ (void)end {
    YJLogDebug(YJTimeline_log);
    YJTimeline_log = nil;
}

@end
