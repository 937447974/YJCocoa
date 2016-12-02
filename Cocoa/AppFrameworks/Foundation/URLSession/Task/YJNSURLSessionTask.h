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

/** */
typedef NS_ENUM(NSInteger, YJNSURLSessionTaskState) {
    YJNSURLSessionTaskStateDefault,   ///< 初始化状态
    YJNSURLSessionTaskStateRunning,   ///< 正在请求
    YJNSURLSessionTaskStateSuspended, ///< 暂停请求
    YJNSURLSessionTaskStateCanceling, ///< 取消请求
    YJNSURLSessionTaskStateSuccess,   ///< 请求成功
    YJNSURLSessionTaskStateFailure,   ///< 请求失败
};

/** NSURLSessionTask*/
@interface YJNSURLSessionTask : NSObject

@property (nonatomic, strong) YJNSURLRequest *request;

@property (nonatomic) BOOL needResume; ///< 是否需要YJNSURLSession执行网络重连

@property (nonatomic, readonly) YJNSURLSessionTaskState state; ///< 任务状态

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
 *  @abstract 暂停请求
 */
- (void)suspend;

/**
 *  @abstract 取消请求
 */
- (void)cancel;

@end

NS_ASSUME_NONNULL_END
