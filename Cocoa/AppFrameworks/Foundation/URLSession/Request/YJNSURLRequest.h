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
#import "NSObject+YJNSDictionaryModel.h"

NS_ASSUME_NONNULL_BEGIN

/** 网络请求方式*/
typedef NS_ENUM(NSInteger, YJNSURLRequestMethod) {
    YJNSURLRequestMethodPOST,  ///< POST请求   增
    YJNSURLRequestMethodDELETE,///< DELETE请求 删
    YJNSURLRequestMethodPUT,   ///< PUT请求    改
    YJNSURLRequestMethodGET    ///< GET请求    查
};

/** NSURLRequest*/
@interface YJNSURLRequest : NSObject

@property (nonatomic, copy) NSString *identifier; ///< 唯一标示
@property (nonatomic) BOOL supportResume;         ///< 是否支持网络重连

@property (nonatomic, weak, readonly) id source; ///< 发起网络请求的对象

@property (nonatomic, copy, readonly) NSString *URL;                ///< 请求地址
@property (nonatomic, readonly) YJNSURLRequestMethod requestMethod; ///< 请求方式
@property (nonatomic, strong, readonly) NSObject *requestModel;     ///< 请求参数模型

@property (nonatomic, readonly) Class responseModelClass; ///< 服务器返回数据对应的模型class

/**
 *  @abstract 初始化YJNSURLRequest或其子类
 *
 *  @param source 发起网络请求的对象（source 传 nil 代表永远接受数据）
 *  @param url       请求地址
 *  @param reqMethod 请求方式
 *  @param reqModel  请求参数模型
 *  @param respModelClass 服务器返回数据对应的模型class
 *
 *  @return instancetype
 */
+ (instancetype)requestWithSource:(nullable id)source url:(NSString *)url reqMethod:(YJNSURLRequestMethod)reqMethod reqModel:(NSObject *)reqModel respModelClass:(Class)respModelClass;

@end

NS_ASSUME_NONNULL_END
