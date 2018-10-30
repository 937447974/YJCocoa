//
//  YJNSRouterNode.h
//  YJCocoa
//
//  HomePage:https://github.com/937447974/YJCocoa
//  YJ技术支持群:557445088
//
//  Created by 阳君 on 2018/10/29.
//  Copyright © 2016年 YJCocoa. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YJNSRouterNodeConfig.h"

NS_ASSUME_NONNULL_BEGIN

/** 路由节点*/
@interface YJNSRouterNode : NSObject

@property (nonatomic, weak) id source; ///< 节点
@property (nonatomic, strong) YJNSRouterNodeConfig *config; ///< 配置

- (instancetype)initWithSource:(id)source config:(YJNSRouterNodeConfig *)config;

@end

NS_ASSUME_NONNULL_END
