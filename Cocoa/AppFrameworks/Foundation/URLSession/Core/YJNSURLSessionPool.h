//
//  YJNSURLSessionPool.h
//  YJCocoa
//
//  HomePage:https://github.com/937447974/YJCocoa
//  YJ技术支持群:557445088
//
//  Created by 阳君 on 2018/7/19.
//  Copyright © 2016年 YJCocoa. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YJNSURLSessionTask.h"
#import "YJNSSingleton.h"
#import "YJNSCache.h"

NS_ASSUME_NONNULL_BEGIN

/** 共享网络会话池*/
#define YJNSURLSessionPoolS YJNSSingletonS(YJNSURLSessionPool, nil)

@interface YJNSURLSessionPool : NSObject <NSCacheDelegate>

@property (nonatomic, strong) YJNSCache<NSString *, YJNSURLSessionTask *> *cache;

@end

NS_ASSUME_NONNULL_END
