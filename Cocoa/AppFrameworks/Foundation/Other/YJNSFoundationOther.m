//
//  YJNSFoundationOther.m
//  YJFoundation
//
//  HomePage:https://github.com/937447974/YJCocoa
//  YJ技术支持群:557445088
//
//
//  Created by 阳君 on 16/5/25.
//  Copyright © 2016年 YJCocoa. All rights reserved.
//

#import "YJNSFoundationOther.h"
#import <objc/runtime.h>
#import "YJDispatch.h"

#pragma mark 获取类名
NSString *YJNSStringFromClass(Class aClass) {
    NSString *className = NSStringFromClass(aClass);
    NSArray<NSString *> *array = [className componentsSeparatedByString:@"."];
    return array.lastObject;
}


@implementation NSObject (YJOther)

+ (NSArray<Class> *)allClassRespondsToSelector:(SEL)aSelector {
    NSMutableArray *result = NSMutableArray.array;
    unsigned int classCount;
    Class *classes = objc_copyClassList(&classCount);
    dispatch_sync_main(^{
        for (int i = 0; i < classCount; i++) {
            Class cls = classes[i];
            if ([YJNSStringFromClass(cls) rangeOfString:@"_"].location != NSNotFound) continue;
            if (class_getClassMethod(cls, aSelector)) [result addObject:cls];
        }
    });
    free(classes);
    return result;
}

@end
