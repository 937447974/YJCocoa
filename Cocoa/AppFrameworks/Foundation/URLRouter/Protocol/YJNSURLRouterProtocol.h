//
//  YJNSURLRouterProtocol.h
//  YJCocoa
//
//  HomePage:https://github.com/937447974/YJCocoa
//  YJ技术支持群:557445088
//
//  Created by 阳君 on 2017/10/17.
//  Copyright © 2017年 YJCocoa. All rights reserved.
//

NS_ASSUME_NONNULL_BEGIN

typedef NSString *YJNSRouterURL NS_STRING_ENUM; ///< 路由地址
typedef NSString *YJNSRouterDataID NS_STRING_ENUM; ///< 路由包接受ID

/** 路由代理*/
@protocol YJNSURLRouterProtocol <NSObject>

@optional

#pragma mark 路由加载

+ (void)loadRouter;

#pragma mark 页面
/**
 *  @abstract 初始化
 *
 *  @param url 路由地址
 *
 *  @return instancetype
 */
+ (instancetype)newWithRouterURL:(YJNSRouterURL)url;

/**
 *  @abstract 刷新当前路由器数据
 *
 *  @param options 携带的数据
 */
- (void)reloadDataWithRouterOptions:(NSDictionary *)options;

/**
 *  @abstract 打开路由
 *
 *  @param completion 路由打开完成回调
 */
- (void)openRouterCompletionHandler:(nullable dispatch_block_t)completion;

#pragma mark 数据接受
/**
 *  @abstract 接收数据
 *
 *  @param dID     YJNSRouterDataID
 *  @param options 配置参数
 *
 *  @return BOOL YES拦截数据，NO不拦截数据
 */
- (BOOL)receiveRouterData:(YJNSRouterDataID)dID options:(nullable NSDictionary *)options;

@end

NS_ASSUME_NONNULL_END

