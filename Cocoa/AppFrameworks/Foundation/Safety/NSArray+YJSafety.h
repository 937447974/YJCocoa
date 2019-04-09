//
//  NSArray+YJSafety.h
//  YJCocoa
//
//  HomePage:https://github.com/937447974/YJCocoa
//  YJ技术支持群:557445088
//
//  Created by 阳君 on 2019/4/9.
//  Copyright © 2019年 YJCocoa. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSArray<ObjectType> (YJSafety)

- (BOOL)boolAtIndex:(NSUInteger)index;
- (NSInteger)integerAtIndex:(NSUInteger)index;
- (CGFloat)floatAtIndex:(NSUInteger)index;

@end

NS_ASSUME_NONNULL_END
