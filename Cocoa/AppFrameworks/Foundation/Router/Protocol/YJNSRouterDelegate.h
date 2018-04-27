//
//  YJNSRouterDelegate.h
//  YJUINavigationRouter
//
//  Created by 阳君 on 2017/10/17.
//  Copyright © 2017年 YJCocoa. All rights reserved.
//

NS_ASSUME_NONNULL_BEGIN

typedef NSString * YJNSRouterURL NS_STRING_ENUM; ///< 路由地址
typedef NSString * YJNSRouterOptionsKey NS_STRING_ENUM; ///< 路由参数Key
typedef NSString * YJNSRouterFoundationID NS_STRING_ENUM; ///< 路由功能ID

@class YJNSRouter;

/** 路由代理*/
@protocol YJNSRouterDelegate <NSObject>

#pragma mark 页面初始化
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
 *  @return BOOL 是否已打开当前路由器
 */
- (BOOL)openCurrentRouterFromSourceRouter:(YJNSRouter *)sourceRouter completion:(void (^)(NSObject *controller))completion;

/**
 *  @abstract 刷新当前路由器数据
 */
- (void)reloadRouterData;

#pragma mark 页面跳转

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

#pragma mark 数据交互
/**
 *  @abstract 发送数据
 *
 *  @param fID     YJNSRouterFoundationID
 *  @param options 配置参数
 *
 *  @return BOOL YES数据已被拦截处理，NO数据未拦截
 */
- (BOOL)sendSourceRouter:(YJNSRouterFoundationID)fID options:(NSDictionary<YJNSRouterOptionsKey, id> *)options;

/**
 *  @abstract 接收数据
 *
 *  @param fID     YJNSRouterFoundationID
 *  @param options 配置参数
 *
 *  @return BOOL YES拦截数据，NO未拦截数据
 */
- (BOOL)receiveTargetRouter:(YJNSRouterFoundationID)fID options:(NSDictionary<YJNSRouterOptionsKey, id> *)options sender:(YJNSRouter *)sender;

@end

NS_ASSUME_NONNULL_END

