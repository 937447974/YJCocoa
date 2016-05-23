//
//  YJFoundation.h
//  YJCocoa
//
//  HomePage:https://github.com/937447974/YJCocoa
//  YJ技术支持群:557445088
//
//  Created by 阳君 on 16/5/11.
//  Copyright © 2016年 YJ. All rights reserved.
//

//NSLog打印优化，Unicode自动转化为中文输出。
#import "YJLog.h"
// 单例管理器
#import "YJSingleton.h"

NS_ASSUME_NONNULL_BEGIN

/** 获取类名，兼容OC和Swift*/
NSString *YJStringFromClass(Class aClass);

/** Foundation Framework*/
@interface YJFoundation : NSObject

@end

NS_ASSUME_NONNULL_END
