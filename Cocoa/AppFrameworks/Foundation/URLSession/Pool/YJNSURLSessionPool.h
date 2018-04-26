//
//  YJNSURLSessionPool.h
//  YJFoundation
//
//  HomePage:https://github.com/937447974/YJCocoa
//  YJ技术支持群:557445088
//
//  Created by 阳君 on 2016/11/30.
//  Copyright © 2016年 YJCocoa. All rights reserved.
//

#ifndef YJNSURLSessionPool_h
#define YJNSURLSessionPool_h

#import "YJNSSingleton.h"

NS_ASSUME_NONNULL_BEGIN

/** 共享网络会话池*/
#define YJNSURLSessionPoolS YJNSSingletonS(NSMutableDictionary, @"YJNSURLSessionPool")

NS_ASSUME_NONNULL_END

#endif /* YJNSURLSessionPool_h */
