//
//  YJCDManagedObject.m
//  YJCoreData
//
//  HomePage:https://github.com/937447974/YJCocoa
//  YJ技术支持群:557445088
//
//  Created by 阳君 on 2016/10/27.
//  Copyright © 2016年 YJCocoa. All rights reserved.
//

#import "YJCDManagedObject.h"
#import "YJCDManager.h"
#import "YJNSFoundationOther.h"

@implementation NSManagedObject (YJCDManagedObject)

+ (instancetype)insertNewObject {
    return [NSEntityDescription insertNewObjectForEntityForName:YJNSStringFromClass(self.class) inManagedObjectContext:YJCDManagerS.mainContext];
}

+ (NSFetchRequest<NSManagedObject *> *)fetchRequest {
    return [[NSFetchRequest alloc] initWithEntityName:YJNSStringFromClass(self.class)];
}

@end
