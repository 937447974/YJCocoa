//
//  YJNSRouterHeader.h
//  YJUINavigationRouter
//
//  HomePage:https://github.com/937447974/YJCocoa
//  YJ技术支持群:557445088
//
//  Created by 阳君 on 2016/12/20.
//  Copyright © 2016年 YJCocoa. All rights reserved.
//

NS_ASSUME_NONNULL_BEGIN

typedef NSString * YJNSRouterURL NS_STRING_ENUM; ///< 路由地址
typedef NSString * YJNSRouterOptionsKey NS_STRING_ENUM; ///< 路由参数Key
typedef NSString * YJNSRouterFoundationID NS_STRING_ENUM; ///< 路由功能ID

@class YJNSRouter;

/** 路由代理*/
@protocol YJNSRouterDelegate <NSObject>

@optional

/**
 *  @abstract 初始化
 *
 *  @param routerURL 路由地址
 *
 *  @return instancetype
 */
- (instancetype)initWithRouterURL:(YJNSRouterURL)routerURL;

/**
 *  @abstract 源路由器打开当前路由器
 *  @discusstion 相关动画操作
 *
 *  @return BOOL 能否打开当前路由器
 */
- (BOOL)openCurrentRouter;

/**
 *  @abstract 接收目标路由器发来的数据
 *
 *  @param fID     YJNSRouterFoundationID
 *  @param options 配置参数
 *
 *  @return BOOL YES拦截数据，NO未拦截数据
 */
- (BOOL)receiveTargetRouter:(YJNSRouterFoundationID)fID options:(NSDictionary<YJNSRouterOptionsKey, id> *)options sender:(YJNSRouter *)sender;

@end

NS_ASSUME_NONNULL_END

