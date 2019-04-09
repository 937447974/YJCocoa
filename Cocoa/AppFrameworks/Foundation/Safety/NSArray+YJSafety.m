//
//  NSArray+YJSafety.m
//  YJCocoa
//
//  HomePage:https://github.com/937447974/YJCocoa
//  YJ技术支持群:557445088
//
//  Created by 阳君 on 2019/4/9.
//  Copyright © 2019年 YJCocoa. All rights reserved.
//

#import "NSArray+YJSafety.h"

@implementation NSArray (YJSafety)

#define YJObjectAt(value, default) if (self.count <= index) return default;\
NSNumber *obj = [self objectAtIndex:index];\
if ([obj isKindOfClass:NSNumber.class] || [obj isKindOfClass:NSString.class])\
return obj.value;\
return default;
- (BOOL)boolAtIndex:(NSUInteger)index {YJObjectAt(boolValue, NO)}
- (NSInteger)integerAtIndex:(NSUInteger)index{YJObjectAt(integerValue, 0)}
- (CGFloat)floatAtIndex:(NSUInteger)index{YJObjectAt(floatValue, 0)}

@end
