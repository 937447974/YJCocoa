//
//  YJNSRouteManager.h
//  YJUINavigationRouter
//
//  HomePage:https://github.com/937447974/YJCocoa
//  YJ技术支持群:557445088
//
//  Created by 阳君 on 2016/12/20.
//  Copyright © 2016年 YJCocoa. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YJNSRouterNode.h"
#import "YJNSSingleton.h"

NS_ASSUME_NONNULL_BEGIN

/** 共享类*/
#define YJNSRouteManagerS YJNSSingletonS(YJNSRouteManager, nil)

/** 路由导航管理器*/
@interface YJNSRouteManager : NSObject

/**
 *  @abstract 注册路由节点
 *
 *  @param routerNode 路由节点
 */
- (void)registerRouterNode:(YJNSRouterNode *)routerNode;

/**
 *  @abstract 获取路由节点
 *
 *  @param routerURL 路由地址
 *
 *  @return nullable YJNSRouterNode
 */
- (nullable YJNSRouterNode *)routerNodeForURL:(YJNSRouterURL)routerURL;

#pragma mark - 节点缓存
/**
 *  @abstract 存放节点对应的控制器
 *
 *  @param routerNode 路由节点
 */
- (void)setObject:(id)anObject forRouterNode:(YJNSRouterNode *)routerNode;

/**
 *  @abstract 获取节点对应的控制器
 *
 *  @param routerNode 路由节点
 *
 *  @return nullable id
 */
- (nullable id)objectForRouterNode:(YJNSRouterNode *)routerNode;

/**
 *  @abstract 释放节点对应控制器
 *
 *  @param routerNode 路由节点
 */
- (void)removeObjectForRouterNode:(YJNSRouterNode *)routerNode;

/**
 *  @abstract 释放指定作用域内的所有控制器
 *
 *  @param scope 路由作用域
 */
- (void)removeObjectsForScope:(YJNSRouterNodeScope)scope;

@end

NS_ASSUME_NONNULL_END
