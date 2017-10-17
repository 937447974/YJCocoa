//
//  YJNSRouterNode.h
//  YJUINavigationRouter
//
//  Created by didi on 2017/10/17.
//  Copyright © 2017年 YJCocoa. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YJNSRouterDelegate.h"

NS_ASSUME_NONNULL_BEGIN

typedef NSString * YJNSRouterNodeScope NS_STRING_ENUM; ///< 节点作用域
FOUNDATION_EXPORT YJNSRouterNodeScope const YJNSRouterNodeScopeSingleton;///< 单例模式
FOUNDATION_EXPORT YJNSRouterNodeScope const YJNSRouterNodeScopePrototype;///< 原型默认

//typedef NSString *NSNotificationName ;
//UIKIT_EXTERN NSNotificationName const UIApplicationDidReceiveMemoryWarningNotification;

/** 路由器的节点*/
@interface YJNSRouterNode : NSObject

@property (nonatomic, readonly) Class routerClass;             ///< 路由目标类（UIViewController子类或看门狗）
@property (nonatomic, readonly) YJNSRouterNodeScope scope;     ///< 节点作用域
@property (nonatomic, copy, readonly) YJNSRouterURL routerURL; ///< 路由地址

/**
 *  @abstract 初始化
 *
 *  @param routerClass 路由目标类（UIViewController子类或看门狗）
 *  @param scope 作用范围，默认 YJNSRouterNodeScopePrototype
 *  @param routerURL 路由地址
 *
 *  @return instancetype
 */
+ (YJNSRouterNode *)nodeWithRouterClass:(Class)routerClass scope:(nullable YJNSRouterNodeScope)scope routerURL:(YJNSRouterURL)routerURL;

@end

NS_ASSUME_NONNULL_END
