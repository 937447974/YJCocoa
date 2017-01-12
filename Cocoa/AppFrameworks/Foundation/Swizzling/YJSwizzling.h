//
//  YJSwizzling.h
//  YJFoundation
//
//  HomePage:https://github.com/937447974/YJCocoa
//  YJ技术支持群:557445088
//
//  Created by 阳君 on 2017/1/12.
//  Copyright © 2017年 YJCocoa. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSObject (YJSwizzling)

/**
 *  @abstract 交换方法
 *
 *  @param originalSEL 原始方法
 *  @param swizzlingSEL 交换的方法
 */
+ (void)swizzlingSEL:(SEL)originalSEL withSEL:(SEL)swizzlingSEL;

@end

NS_ASSUME_NONNULL_END
