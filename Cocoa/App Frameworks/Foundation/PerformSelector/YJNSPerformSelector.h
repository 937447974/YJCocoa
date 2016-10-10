//
//  YJNSPerformSelector.h
//  YJFoundation
//
//  HomePage:https://github.com/937447974/YJCocoa
//  YJ技术支持群:557445088
//
//  Created by 阳君 on 16/7/25.
//  Copyright © 2016年 YJCocoa. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

/** 安全执行方法的回调*/
@interface YJNSPerformSelector : NSObject

@property (nonatomic) BOOL success;        ///< 方法是否执行通过
@property (nonatomic, nullable) id result; ///< 方法执行后的结果

/**
 *  初始化
 *
 *  @return instancetype
 */
- (instancetype)initWithSuccess:(BOOL)success result:(nullable id)result;

@end

NS_ASSUME_NONNULL_END
