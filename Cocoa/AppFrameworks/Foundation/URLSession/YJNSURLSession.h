//
//  YJNSURLSession.h
//  YJFoundation
//
//  HomePage:https://github.com/937447974/YJCocoa
//  YJ技术支持群:557445088
//
//  Created by 阳君 on 2016/11/29.
//  Copyright © 2016年 YJCocoa. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YJNSURLSessionTask.h"
#import "YJNSURLSessionPool.h"

NS_ASSUME_NONNULL_BEGIN

/** NSURLSession*/
@interface YJNSURLSession : NSObject

/**
 *  @abstract 通过request获取task
 *
 *  @param request YJNSURLRequest
 *
 *  @return YJNSURLSessionTask
 */
+ (__kindof YJNSURLSessionTask *)taskWithRequest:(YJNSURLRequest *)request;

/**
 *  @abstract 重新执行所有失败的任务
 *  @discusstion 用户从无网回到有网时，可通过此方法快速恢复业务
 */
+ (void)resumeAllFailedTask;

@end

NS_ASSUME_NONNULL_END
