//
//  YJNSURLRouter.h
//  YJCocoa
//
//  HomePage:https://github.com/937447974/YJCocoa
//  YJ技术支持群:557445088
//
//  Created by 阳君 on 2018/10/18.
//  Copyright © 2016年 YJCocoa. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YJNSSingleton.h"
#import "YJNSRouterRegister.h"

NS_ASSUME_NONNULL_BEGIN

/** 共享类*/
#define YJNSURLRouterS YJNSSingletonS(YJNSURLRouter, nil)
/** 路由 url 加载*/
#define ROUTER_LOAD_URL(url,isCache) + (void)routerLoad {[YJNSURLRouterS registerRouter:[[YJNSRouterRegister alloc] initWithURL:url cache:isCache cls:self]];}

/** URL 路由器*/
@interface YJNSURLRouter : NSObject

/**
 *  @abstract 注册路由
 *
 *  @param rRegister 路由节点
 */
- (void)registerRouter:(YJNSRouterRegister *)rRegister;

/**
 *  @abstract 拦截未注册的路由
 *
 *  @param canOpen     能否打开路由
 *  @param openHandler 打开路由
 */
- (void)interceptUnregisteredCanOpen:(YJRUnregisteredCanOpen)canOpen openHandler:(YJROpenHandler)openHandler;

/**
 *  @abstract 能否打开路由
 *
 *  @param url 路由链接
 *
 *  @return BOOL
 */
- (BOOL)canOpenURL:(NSString *)url;

/**
 *  @abstract 打开路由
 *
 *  @param url 路由链接
 *  @param options 参数
 *  @param completionHandler 执行操作后的回调
 */
- (void)openURL:(NSString *)url options:(nullable NSDictionary *)options completionHandler:(nullable YJRCompletionHandler)completionHandler;

@end

NS_ASSUME_NONNULL_END
