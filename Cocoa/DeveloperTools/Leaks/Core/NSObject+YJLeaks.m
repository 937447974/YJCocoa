//
//  NSObject+YJLeaks.m
//  YJLeaks
//
//  HomePage:https://github.com/937447974/YJCocoa
//  YJ技术支持群:557445088
//
//  Created by 阳君 on 2017/1/13.
//  Copyright © 2017年 YJCocoa. All rights reserved.
//

#import "NSObject+YJLeaks.h"
#import "YJLeaksTool.h"

@implementation NSObject (YJLeaks)

+ (void)startCaptureMemoryLeaks {
    [self doesNotRecognizeSelector:_cmd];
}

- (void)captureMemoryLeaks {
    [YJLeaksToolS captureTargetMemoryLeaks:self];
}
 
@end

