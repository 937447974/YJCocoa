//
//  YJCDFaulter.m
//  YJCoreData
//
//  HomePage:https://github.com/937447974/YJCocoa
//  YJ技术支持群:557445088
//
//  Created by 阳君 on 2016/10/31.
//  Copyright © 2016年 YJCocoa. All rights reserved.
//

#import "YJCDFaulter.h"

@implementation YJCDFaulter

+ (void)faultObjectWithID:(NSManagedObjectID *)objectID inContext:(NSManagedObjectContext *)context {
    if (!objectID || !context) {
        return;
    }
    [context performBlockAndWait:^{
        NSManagedObject *object = [context objectWithID:objectID];
        // 是否有变化
        if (object.hasChanges) {
            NSError *error;
            if (![context save:&error]) {
                NSLog(@"从上下文保存对象到持久化存储区中失败: %@", error);
            }
        }
        // 是否Fault
        if (!object.isFault) {
            [context refreshObject:object mergeChanges:NO];
        }
        // 当有父上下文时，让父上下文重复执行这个操作
        if (context.parentContext) {
            [self faultObjectWithID:objectID inContext:context.parentContext];
        }
    }];
}

@end
