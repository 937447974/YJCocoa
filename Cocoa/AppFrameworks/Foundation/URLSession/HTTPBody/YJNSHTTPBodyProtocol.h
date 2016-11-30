//
//  YJNSHTTPBodyProtocol.h
//  YJFoundation
//
//  HomePage:https://github.com/937447974/YJCocoa
//  YJ技术支持群:557445088
//
//  Created by admin on 2016/11/29.
//  Copyright © 2016年 YJCocoa. All rights reserved.
//

#import "NSObject+YJNSDictionaryModel.h" // 借助DictionaryModel库快速实现面向对象封装数据

NS_ASSUME_NONNULL_BEGIN

/** 发送网络请求携带的参数协议*/
@protocol YJNSHTTPBodyProtocol <NSObject>

@property (class, readonly) Class responseClass; ///< 服务器返回数据对应的模型

@end

NS_ASSUME_NONNULL_END
