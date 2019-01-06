//
//  YJNSRouterRegister.h
//  YJUINavigationRouter
//
//  Created by 阳君 on 2017/10/17.
//  Copyright © 2017年 YJCocoa. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YJNSURLRouterProtocol.h"

NS_ASSUME_NONNULL_BEGIN

/** 路由节点注册*/
@interface YJNSRouterRegister : NSObject

@property (nonatomic) BOOL cache; ///< 是否缓存
@property (nonatomic, copy) NSString *url; ///< 地址

@property (nonatomic) Class cls; ///< 节点YJNSURLRouterProtocol实现类
@property (nonatomic, copy, nullable) YJROpenHandler handler; ///< 节点block实现回调

/**
 *  @abstract 初始化
 *
 *  @param url YJNSRouterURL
 *  @param cache 是否缓存
 *  @param cls   节点YJNSURLRouterProtocol实现类
 *
 *  @return instancetype
 */
- (instancetype)initWithURL:(NSString *)url cache:(BOOL)cache cls:(Class)cls;

/**
 *  @abstract 初始化
 *
 *  @param url YJNSRouterURL
 *  @param handler YJNSRouterNodeConfigHandler
 *
 *  @return instancetype
 */
- (instancetype)initWithURL:(NSString *)url handler:(YJROpenHandler)handler;

@end

NS_ASSUME_NONNULL_END
