//
//  YJSchedulerCallBack.h
//  YJCocoa
//
//  Created by CISDI on 2018/12/29.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

/** 成功回调*/
typedef void (^ YJSchedulerSuccess)(__nullable id data);
/** 失败回调*/
typedef void (^ YJSchedulerFailure)(NSError *error);

/** 调度器回调*/
@interface YJSchedulerCallBack : NSObject

@property (nonatomic, copy, nullable) YJSchedulerSuccess success; ///< 成功回调
@property (nonatomic, copy, nullable) YJSchedulerFailure failure; ///< 失败回调

- (void)completionSuccess:(YJSchedulerSuccess)success failure:(nullable YJSchedulerFailure)failure;

@end

NS_ASSUME_NONNULL_END
