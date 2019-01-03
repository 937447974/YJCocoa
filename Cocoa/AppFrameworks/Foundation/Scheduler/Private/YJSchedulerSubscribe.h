//
//  YJSchedulerSubscribe.h
//  Pods
//
//  Created by CISDI on 2018/12/29.
//

#import <Foundation/Foundation.h>
#import "YJSchedulerHeader.h"

NS_ASSUME_NONNULL_BEGIN

/** 调度器订阅*/
@interface YJSchedulerSubscribe : NSObject

@property (nonatomic, copy) NSString *topic;
@property (nonatomic, weak) id subscriber;
@property (nonatomic) YJSchedulerQueue queue;
@property (nonatomic, copy) YJSSubscribeHandler completionHandler;

- (instancetype)initWithTopic:(NSString *)topic subscriber:(id)subscriber queue:(YJSchedulerQueue)queue completionHandler:(YJSSubscribeHandler)completionHandler;

@end

NS_ASSUME_NONNULL_END

