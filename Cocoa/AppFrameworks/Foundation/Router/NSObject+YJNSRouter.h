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
@interface NSObject (YJNSRouter) <YJNSRouterDelegate>

@property (nonatomic, strong) YJNSRouter *router; ///< 当前路由

@end

NS_ASSUME_NONNULL_END
