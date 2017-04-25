//
//  YJTimePageProfiler.m
//  YJTimeProfiler
//
//  HomePage:https://github.com/937447974/YJCocoa
//  YJ技术支持群:557445088
//
//  Created by 阳君 on 2017/4/24.
//  Copyright © 2017年 YJCocoa. All rights reserved.
//

#import "YJTimePageProfiler.h"
#import "YJSwizzling.h"
#import "YJNSSingleton.h"

@interface YJTimePageProfiler ()

@property (nonatomic, strong) NSMutableDictionary<NSString *, NSString *> *timeInit;
@property (nonatomic, strong) NSMutableDictionary<NSString *, NSString *> *timeLoad;
@property (nonatomic, strong) NSMutableDictionary<NSString *, NSString *> *timeWillAppear;

@end

#if DEBUG
@interface UIViewController (YJTimePageProfiler)
+ (void)startTimePageProfiler;
@end
#endif

@implementation YJTimePageProfiler

- (instancetype)init {
    self = [super init];
    if (self) {
        self.timeInit = [NSMutableDictionary dictionary];
        self.timeLoad = [NSMutableDictionary dictionary];
        self.timeWillAppear = [NSMutableDictionary dictionary];
    }
    return self;
}

+ (void)start {
#if DEBUG
    [UIViewController startTimePageProfiler];
#endif
}

@end

#if DEBUG
@implementation UIViewController (YJTimePageProfiler)

+ (void)startTimePageProfiler {
    [self swizzlingSEL:@selector(init) withSEL:@selector(swizzling_init)];
    [self swizzlingSEL:@selector(viewDidLoad) withSEL:@selector(swizzling_viewDidLoad)];
    [self swizzlingSEL:@selector(viewWillAppear:) withSEL:@selector(swizzling_viewWillAppear:)];
    [self swizzlingSEL:@selector(viewDidAppear:) withSEL:@selector(swizzling_viewDidAppear:)];
}

- (instancetype)swizzling_init {
    NSMutableString *mStr = [NSMutableString string];
    [mStr appendFormat:@"\t%.3f %@ start\n", CFAbsoluteTimeGetCurrent(), NSStringFromSelector(_cmd)];
    id obj = [self swizzling_init];
    [mStr appendFormat:@"\t%.3f %@ end\n", CFAbsoluteTimeGetCurrent(), NSStringFromSelector(_cmd)];
    [self.timePageProfiler.timeInit setObject:mStr forKey:NSStringFromClass(self.class)];
    return obj;
}

- (void)swizzling_viewDidLoad {
    NSMutableString *mStr = [NSMutableString string];
    [mStr appendFormat:@"\t%.3f %@ start\n", CFAbsoluteTimeGetCurrent(), NSStringFromSelector(_cmd)];
    [self swizzling_viewDidLoad];
    [mStr appendFormat:@"\t%.3f %@ end\n", CFAbsoluteTimeGetCurrent(), NSStringFromSelector(_cmd)];
    [self.timePageProfiler.timeLoad setObject:mStr forKey:NSStringFromClass(self.class)];
}

- (void)swizzling_viewWillAppear:(BOOL)animated {
    NSMutableString *mStr = [NSMutableString string];
    [mStr appendFormat:@"\t%.3f %@ start\n", CFAbsoluteTimeGetCurrent(), NSStringFromSelector(_cmd)];
    [self swizzling_viewWillAppear:animated];
    [mStr appendFormat:@"\t%.3f %@ end\n", CFAbsoluteTimeGetCurrent(), NSStringFromSelector(_cmd)];
    [self.timePageProfiler.timeWillAppear setObject:mStr forKey:NSStringFromClass(self.class)];
}

- (void)swizzling_viewDidAppear:(BOOL)animated {
    YJTimePageProfiler *timePageProfiler = self.timePageProfiler;
    NSString *className = NSStringFromClass(self.class);
    if ([timePageProfiler.timeLoad objectForKey:className]) {
        NSMutableString *mStr = [NSMutableString string];
        [mStr appendFormat:@"%@: {\n", className];
        [mStr appendFormat:@"%@", [timePageProfiler.timeInit objectForKey:className]];
        [mStr appendFormat:@"%@", [timePageProfiler.timeLoad objectForKey:className]];
        [mStr appendFormat:@"%@", [timePageProfiler.timeWillAppear objectForKey:className]];
        [mStr appendFormat:@"\t%.3f %@ start\n", CFAbsoluteTimeGetCurrent(), NSStringFromSelector(_cmd)];
        [self swizzling_viewDidAppear:animated];
        [mStr appendFormat:@"\t%.3f %@ end\n}", CFAbsoluteTimeGetCurrent(), NSStringFromSelector(_cmd)];
        NSLog(@"%@", mStr);
    } else {
        [self swizzling_viewDidAppear:animated];
    }
    [timePageProfiler.timeInit removeObjectForKey:className];
    [timePageProfiler.timeLoad removeObjectForKey:className];
    [timePageProfiler.timeWillAppear removeObjectForKey:className];
}

- (YJTimePageProfiler *)timePageProfiler {
    return YJNSSingletonW(YJTimePageProfiler, nil);
}

@end
#endif
