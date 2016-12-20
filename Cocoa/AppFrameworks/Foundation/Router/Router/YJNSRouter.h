//
//  YJNSRouter.h
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

NS_ASSUME_NONNULL_BEGIN

/** 路由导航实体*/
@interface YJNSRouter : NSObject

@property (nonatomic, weak)   YJNSRouter *sourceRouter;                              ///< 来源路由
@property (nonatomic, strong) NSDictionary<YJNSRouterOptionsKey, id> *sourceOptions; ///< 来源配置

@property (nonatomic, copy) YJNSRouterURL routerURL; ///< 路由地址
@property (nonatomic, weak) id currentController;    ///< 当前控制器，默认VC

@property (nonatomic, copy) BOOL (^ completionHandler)(YJNSRouterFoundationID fID, NSDictionary<YJNSRouterOptionsKey, id> *options, YJNSRouter *sender); ///< 接收目标路由传回信息, return（YES(拦截，NO继续下发)

@end

NS_ASSUME_NONNULL_END
