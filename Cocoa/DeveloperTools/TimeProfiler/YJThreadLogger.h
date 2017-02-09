//
//  YJThreadLogger.h
//  YJTimeProfiler
//
//  HomePage:https://github.com/937447974/YJCocoa
//  YJ技术支持群:557445088
//
//  Created by 阳君 on 2017/2/9.
//  Copyright © 2017年 YJCocoa. All rights reserved.
//

#import <Foundation/Foundation.h>

/** 线程日志记录器*/
@interface YJThreadLogger : NSObject

@property (nonatomic, copy, readonly) NSString *log; ///< 线程堆栈信息

@end
