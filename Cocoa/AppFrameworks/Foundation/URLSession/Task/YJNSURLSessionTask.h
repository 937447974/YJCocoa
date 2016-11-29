//
//  YJNSURLSessionTask.h
//  YJFoundation
//
//  HomePage:https://github.com/937447974/YJCocoa
//  YJ技术支持群:557445088
//
//  Created by 阳君 on 2016/11/29.
//  Copyright © 2016年 YJCocoa. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YJNSURLRequest.h"

NS_ASSUME_NONNULL_BEGIN

typedef void (^ YJNSURLSessionTaskSuccess)(__kindof NSObject *data, NSURLResponse *response);
typedef void (^ YJNSURLSessionTaskFailure)(NSError *error);

/** NSURLSessionTask*/
@interface YJNSURLSessionTask : NSObject

@property (nonatomic, strong) YJNSURLRequest *request;

@property (nonatomic, copy) YJNSURLSessionTaskSuccess success; ///< 成功回调
@property (nonatomic, copy) YJNSURLSessionTaskFailure failure; ///< 失败回调

/**
 *  @abstract 链式设置回调
 *  @discusstion 建议使用此方法
 *
 *  @param success 成功回调
 *  @param failure 失败回调
 *
 *  @return instancetype
 */
- (instancetype)completionHandler:(YJNSURLSessionTaskSuccess)success failure:(nullable YJNSURLSessionTaskFailure)failure;

/**
 *  @abstract 发送请求
 */
- (void)resume;

/**
 *  @abstract 取消请求
 */
- (void)cancel;

@end

NS_ASSUME_NONNULL_END
