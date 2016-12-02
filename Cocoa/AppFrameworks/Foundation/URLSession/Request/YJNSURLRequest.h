//
//  YJNSURLRequest.h
//  YJFoundation
//
//  HomePage:https://github.com/937447974/YJCocoa
//  YJ技术支持群:557445088
//
//  Created by 阳君 on 2016/11/29.
//  Copyright © 2016年 YJCocoa. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YJNSHTTPBodyProtocol.h"

NS_ASSUME_NONNULL_BEGIN

typedef NSString * YJNSHTTPMethod NS_STRING_ENUM; ///< 请求方式
FOUNDATION_EXPORT YJNSHTTPMethod const YJNSHTTPMethodGET;  ///< GET请求
FOUNDATION_EXPORT YJNSHTTPMethod const YJNSHTTPMethodPOST; ///< POST请求

/** NSURLRequest*/
@interface YJNSURLRequest : NSObject

@property (nonatomic) BOOL supportResume; ///< 是否支持网络重连

@property (nonatomic, copy) NSString *identifier; ///< 唯一标示

@property (nonatomic, weak, readonly) id source; ///< 发起网络请求的对象
@property (nonatomic, readonly) Class URLSessionTask;  ///< 网络会话任务对应的类

@property (nonatomic, copy) NSString *URL;             ///< 请求地址
@property (nonatomic, copy) YJNSHTTPMethod HTTPMethod; ///< 请求方式，默认YJNSHTTPMethodGET
@property (nonatomic, strong) __kindof NSObject<YJNSHTTPBodyProtocol> *HTTPBody;  ///< 请求参数

/**
 *  @abstract 初始化YJNSURLRequest或其子类
 *
 *  @param source 发起网络请求的对象
 *
 *  @return instancetype
 */
+ (instancetype)requestWithSource:(NSObject *)source;

@end

NS_ASSUME_NONNULL_END
