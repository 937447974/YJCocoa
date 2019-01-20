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

/** 路由回调*/
typedef void (^ YJRCompletionHandler)(NSDictionary * _Nullable options);
/** 未注册url能否打开*/
typedef BOOL (^ YJRUnregisteredCanOpen)(NSString *url);
/** 打开路由*/
typedef void (^ YJROpenHandler)(NSString *url, NSDictionary *options, YJRCompletionHandler _Nullable handler);

/** 路由代理*/
@protocol YJNSURLRouterProtocol <NSObject>

@optional

/**
 *  @abstract 路由器加载
 */
+ (void)routerLoad;

/**
 *  @abstract 获取路由缓存标识符
 *
 *  @param url 路由地址
 *  @param options 携带的数据
 *
 *  @return NSString
 */
+ (NSString *)routerCacheIdentifierWithURL:(NSString *)url options:(nullable NSDictionary *)options;

/**
 *  @abstract 路由器初始化
 *
 *  @param url 路由地址
 *
 *  @return instancetype
 */
+ (instancetype)routerWithURL:(NSString *)url;

/**
 *  @abstract 路由器刷新数据
 *
 *  @param options 携带的数据
 *  @param completionHandler 路由器执行相关操作后的回调
 */
- (void)routerReloadDataWithOptions:(nullable NSDictionary *)options completionHandler:(nullable YJRCompletionHandler)completionHandler;

/**
 *  @abstract 路由器打开
 */
- (void)routerOpen;

@end

NS_ASSUME_NONNULL_END

