//
//  YJNSURLRequestModel.h
//  YJFoundation
//
//  HomePage:https://github.com/937447974/YJCocoa
//  YJ技术支持群:557445088
//
//  Created by 阳君 on 2017/1/9.
//  Copyright © 2017年 YJCocoa. All rights reserved.
//

#import "NSObject+YJNSDictionaryModel.h" // 借助DictionaryModel库快速实现面向对象封装数据

NS_ASSUME_NONNULL_BEGIN

/** 发送网络请求携带的参数协议*/
@protocol YJNSURLRequestModel <NSObject>

@optional
@property (nonatomic, strong, readonly) NSDictionary *modelDictionary; ///< 发送到服务器的模型字典

@end

NS_ASSUME_NONNULL_END

