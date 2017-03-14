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
#import "YJNSRouterHeader.h"
#import "YJNSSingleton.h"

NS_ASSUME_NONNULL_BEGIN

/** 共享类*/
#define YJNSRouteManagerS YJNSSingletonS(YJNSRouteManager, nil)

/** 路由导航管理器*/
@interface YJNSRouteManager : NSObject

/**
 *  @abstract 注册路由
 *
 *  @param routerClass 路由目标类（UIViewController子类或看门狗）
 *  @param routerURL   路由地址
 */
- (void)registerRouter:(Class)routerClass forURL:(YJNSRouterURL)routerURL;

/**
 *  @abstract 获取路由类
 *
 *  @param routerURL 路由地址
 *
 *  @return nullable Class
 */
- (nullable Class)routerClassForURL:(YJNSRouterURL)routerURL;

@end

NS_ASSUME_NONNULL_END
