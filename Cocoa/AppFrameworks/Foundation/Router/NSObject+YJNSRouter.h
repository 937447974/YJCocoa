//
//  NSObject+YJNSRouter.h
//  YJUINavigationRouter
//
//  HomePage:https://github.com/937447974/YJCocoa
//  YJ技术支持群:557445088
//
//  Created by 阳君 on 2016/12/20.
//  Copyright © 2016年 YJCocoa. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YJNSRouter.h"
#import "YJNSRouteManager.h"

NS_ASSUME_NONNULL_BEGIN

/** 路由器扩展*/
@interface NSObject (YJNSRouter)

@property (nonatomic, strong) YJNSRouter *router; ///< 路由

/**
 *  @abstract 通过路由地址打开目标路由器（get跳转）
 *  @discusstion 当前路由器打开下个路由器
 *
 *  @param routerURL  目标路由地址
 *
 *  @return BOOL 能否打开目标路由器
 */
- (BOOL)openRouterURL:(YJNSRouterURL)routerURL;

/**
 *  @abstract 通过路由地址打开目标路由器（post跳转）
 *  @discusstion 当前路由器打开下个路由器
 *
 *  @param routerURL  目标路由地址
 *  @param options    配置参数
 *
 *  @return BOOL 能否打开目标路由器
 */
- (BOOL)openRouterURL:(YJNSRouterURL)routerURL options:(NSDictionary<YJNSRouterOptionsKey, id> *)options;

/**
 *  @abstract 向来源路由器发送数据
 *
 *  @param fID     YJNSRouterFoundationID
 *  @param options 配置参数
 *
 *  @return BOOL YES数据已被拦截处理，NO数据未拦截
 */
- (BOOL)sendSourceRouter:(YJNSRouterFoundationID)fID options:(NSDictionary<YJNSRouterOptionsKey, id> *)options;

@end

NS_ASSUME_NONNULL_END
