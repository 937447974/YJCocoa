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

@end
