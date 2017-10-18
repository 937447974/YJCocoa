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

typedef NSString * YJNSRouterScope NS_STRING_ENUM; ///< 节点作用域
FOUNDATION_EXPORT YJNSRouterScope const YJNSRouterScopeSingleton;///< 单例模式
FOUNDATION_EXPORT YJNSRouterScope const YJNSRouterScopePrototype;///< 原型默认
FOUNDATION_EXPORT YJNSRouterScope const YJNSRouterScopeMemoryWarning;///< 内存警告模式(内存警告时自动释放对应的控制器)

/** 路由器的节点*/
@interface YJNSRouterNode : NSObject

@property (nonatomic, readonly) Class routerClass;             ///< 路由目标类（UIViewController子类或看门狗）
@property (nonatomic, readonly) YJNSRouterScope scope;     ///< 节点作用域
@property (nonatomic, copy, readonly) YJNSRouterURL routerURL; ///< 路由地址

/**
 *  @abstract 初始化
 *
 *  @param routerClass 路由目标类（UIViewController子类或看门狗）
 *  @param scope 作用范围，默认 YJNSRouterScopePrototype
 *  @param routerURL 路由地址
 *
 *  @return instancetype
 */
+ (YJNSRouterNode *)nodeWithRouterClass:(Class)routerClass scope:(nullable YJNSRouterScope)scope routerURL:(YJNSRouterURL)routerURL;

@end

NS_ASSUME_NONNULL_END
