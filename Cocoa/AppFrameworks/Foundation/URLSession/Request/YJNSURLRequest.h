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
#import "YJNSURLRequestModel.h"

NS_ASSUME_NONNULL_BEGIN

typedef NSString * YJNSURLRequestMethod NS_STRING_ENUM; ///< 请求方式
FOUNDATION_EXPORT YJNSURLRequestMethod const YJNSURLRequestMethodGET;  ///< GET请求
FOUNDATION_EXPORT YJNSURLRequestMethod const YJNSURLRequestMethodPOST; ///< POST请求

/** NSURLRequest*/
@interface YJNSURLRequest : NSObject

@property (nonatomic, copy) NSString *identifier; ///< 唯一标示
@property (nonatomic) BOOL supportResume;         ///< 是否支持网络重连

@property (nonatomic, weak, readonly) id source; ///< 发起网络请求的对象

@property (nonatomic, copy)   NSString *URL;                        ///< 请求地址
@property (nonatomic, copy)   YJNSURLRequestMethod requestMethod;   ///< 请求方式
@property (nonatomic, strong) id<YJNSURLRequestModel> requestModel; ///< 请求参数模型

@property (nonatomic) Class responseModelClass; ///< 服务器返回数据对应的模型class

/**
 *  @abstract 初始化YJNSURLRequest或其子类
 *  @discusstion 建议取消网络请求时使用
 *
 *  @param source 发起网络请求的对象
 *
 *  @return instancetype
 */
+ (instancetype)requestWithSource:(id)source;

/**
 *  @abstract 初始化YJNSURLRequest或其子类
 *  @discusstion 建议发送网络请求时使用
 *
 *  @param source 发起网络请求的对象
 *  @param requestModel 请求参数模型
 *
 *  @return instancetype
 */
+ (instancetype)requestWithSource:(id)source requestModel:(id<YJNSURLRequestModel>)requestModel;

@end

NS_ASSUME_NONNULL_END
