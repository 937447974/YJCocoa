//
//  YJNSRouterNodeConfig.h
//  YJUINavigationRouter
//
//  Created by 阳君 on 2017/10/17.
//  Copyright © 2017年 YJCocoa. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YJNSURLRouterProtocol.h"

NS_ASSUME_NONNULL_BEGIN

@class YJNSRouterNodeConfig;

/** 节点block实现回调*/
typedef _Nullable id<YJNSURLRouterProtocol> (^ YJNSRouterNodeConfigHandler)(NSDictionary *options, dispatch_block_t completion);

/** 路由节点配置*/
@interface YJNSRouterNodeConfig : NSObject

@property (nonatomic) BOOL cache; ///< 是否缓存
@property (nonatomic, copy) YJNSRouterURL url; ///< 地址

@property (nonatomic) Class cls; ///< 节点YJNSURLRouterProtocol实现类
@property (nonatomic, copy, nullable) YJNSRouterNodeConfigHandler handler; ///< 节点block实现回调

/**
 *  @abstract 初始化
 *
 *  @param url YJNSRouterURL
 *  @param cache 是否缓存
 *  @param cls   节点YJNSURLRouterProtocol实现类
 *
 *  @return instancetype
 */
- (instancetype)initWithRouterURL:(YJNSRouterURL)url cache:(BOOL)cache cls:(Class)cls;

/**
 *  @abstract 初始化
 *
 *  @param url YJNSRouterURL
 *  @param handler YJNSRouterNodeConfigHandler
 *
 *  @return instancetype
 */
- (instancetype)initWithRouterURL:(YJNSRouterURL)url handler:(YJNSRouterNodeConfigHandler)handler;

@end

NS_ASSUME_NONNULL_END
