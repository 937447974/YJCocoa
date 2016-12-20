//
//  YJNSRouter.m
//  YJUINavigationRouter
//
//  HomePage:https://github.com/937447974/YJCocoa
//  YJ技术支持群:557445088
//
//  Created by 阳君 on 2016/12/20.
//  Copyright © 2016年 YJCocoa. All rights reserved.
//

#import "YJNSRouter.h"

@implementation YJNSRouter

#pragma mark - getter &setter
- (BOOL (^)(YJNSRouterFoundationID _Nonnull, NSDictionary<YJNSRouterOptionsKey,id> * _Nonnull, YJNSRouter * _Nonnull))completionHandler {
    if (!_completionHandler) {
        _completionHandler = ^ BOOL(YJNSRouterFoundationID fID, NSDictionary<YJNSRouterOptionsKey, id> *options, YJNSRouter *sender) {
            return NO;
        };
    }
    return _completionHandler;
}

@end
