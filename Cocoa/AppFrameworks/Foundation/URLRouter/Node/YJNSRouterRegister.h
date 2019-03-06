//
//  YJNSRouterRegister.h
//  YJUINavigationRouter
//
//  Created by 阳君 on 2017/10/17.
//  Copyright © 2017年 YJCocoa. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YJNSURLRouterProtocol.h"

NS_ASSUME_NONNULL_BEGIN

/** 路由节点注册*/
@interface YJNSRouterRegister : NSObject

@property (nonatomic) BOOL cache; ///< 是否缓存
@property (nonatomic, copy) NSString *url; ///< 地址

@property (nonatomic) Class cls; ///< 节点YJNSURLRouterProtocol实现类
@property (nonatomic, copy, nullable) YJROpenHandler handler; ///< 节点block实现回调

/**
 *  @abstract 初始化
 *
 *  @param cls   节点实现类
 *  @param url   节点对应的路径
 *  @param cache 是否缓存
 *
 *  @return instancetype
 */
- (instancetype)initWithClass:(Class)cls url:(NSString *)url cache:(BOOL)cache;

/**
 *  @abstract 初始化
 *
 *  @param url YJNSRouterURL
 *  @param handler YJNSRouterNodeConfigHandler
 *
 *  @return instancetype
 */
- (instancetype)initWithURL:(NSString *)url handler:(YJROpenHandler)handler;

@end

NS_ASSUME_NONNULL_END
