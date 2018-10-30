//
//  YJNSURLRouter.h
//  YJCocoa
//
//  HomePage:https://github.com/937447974/YJCocoa
//  YJ技术支持群:557445088
//
//  Created by 阳君 on 2018/10/18.
//  Copyright © 2016年 YJCocoa. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YJNSSingleton.h"
#import "YJNSRouterNodeConfig.h"

/** 共享类*/
#define YJNSURLRouterS YJNSSingletonS(YJNSURLRouter, nil)

NS_ASSUME_NONNULL_BEGIN

/** YJNSURLRouter 代理*/
@protocol YJNSURLRouterDelegate <NSObject>

/**
 *  @abstract 能否打开未注册的路由
 *
 *  @param url 路由链接
 *
 *  @return BOOL
 */
- (BOOL)canOpenUnregisteredURL:(NSString *)url;

/**
 *  @abstract 打开未注册的路由
 *
 *  @param url 路由链接
 *  @param options 参数
 *  @param completion 打开后的回调
 */
- (void)openUnregisteredURL:(NSString *)url options:(nullable NSDictionary *)options completionHandler:(nullable dispatch_block_t)completion;

@end


/** URL 路由器*/
@interface YJNSURLRouter : NSObject

@property (nonatomic, weak, nullable) id<YJNSURLRouterDelegate> delegate; ///< 代理

/**
 *  @abstract 注册路由节点配置
 *
 *  @param config 路由节点配置
 */
- (void)registerNodeConfig:(YJNSRouterNodeConfig *)config;

/**
 *  @abstract 能否打开路由
 *
 *  @param url 路由链接
 *
 *  @return BOOL
 */
- (BOOL)canOpenURL:(NSString *)url;

/**
 *  @abstract 打开路由
 *
 *  @param url 路由链接
 */
- (void)openURL:(NSString *)url;

/**
 *  @abstract 打开路由
 *
 *  @param url 路由链接
 *  @param options 参数
 *  @param completion 打开后的回调
 */
- (void)openURL:(NSString *)url options:(nullable NSDictionary *)options completionHandler:(nullable dispatch_block_t)completion;

/**
 *  @abstract 下线路由节点
 *  @discusstion 带缓存功能的路由节点下线时使用
 *
 *  @param node 路由节点
 */
- (void)offlineNode:(id<YJNSURLRouterProtocol>)node;

/**
 *  @abstract 向路由发送数据
 *
 *  @param dID 路由数据包id
 *  @param options 发送的数据
 */
- (BOOL)sendData:(YJNSRouterDataID)dID options:(nullable NSDictionary *)options;

@end

NS_ASSUME_NONNULL_END
