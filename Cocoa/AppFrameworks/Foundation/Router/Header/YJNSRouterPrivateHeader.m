//
//  YJNSRouterPrivateHeader.m
//  YJUINavigationRouter
//
//  HomePage:https://github.com/937447974/YJCocoa
//  YJ技术支持群:557445088
//
//  Created by 阳君 on 2017/3/13.
//  Copyright © 2017年 YJCocoa. All rights reserved.
//

#import "YJNSRouterPrivateHeader.h"

@implementation NSObject (YJPrivateHeader)

- (instancetype)initWithRouterURL:(YJNSRouterURL)routerURL {
    return [self init];
}

- (BOOL)openCurrentRouter {
    return NO;
}

- (BOOL)receiveTargetRouter:(YJNSRouterFoundationID)fID options:(NSDictionary<YJNSRouterOptionsKey,id> *)options sender:(YJNSRouter *)sender {
    return NO;
}

@end
