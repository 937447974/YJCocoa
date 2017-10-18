//
//  YJNSLog.h
//  YJFoundation
//
//  HomePage:https://github.com/937447974/YJCocoa
//  YJ技术支持群:557445088
//
//  Created by 阳君 on 16/5/20.
//  Copyright © 2016年 YJCocoa. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

/** 快速打印对象*/
FOUNDATION_EXPORT void NSLogS(id obj);

// 样式：[NSArray]、{NSDictionary}、{(NSSet)}

/** 数组NSLog打印扩展*/
@interface NSArray (YJNSLog)
@end

/** 字典NSLog打印扩展*/
@interface NSDictionary (YJNSLog)
@end

/** NSSet打印扩展*/
@interface NSSet (YJNSLog)
@end

NS_ASSUME_NONNULL_END
