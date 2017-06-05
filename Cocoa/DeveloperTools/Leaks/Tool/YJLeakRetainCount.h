//
//  YJLeakRetainCount.h
//  YJLeaks
//
//  HomePage:https://github.com/937447974/YJCocoa
//  YJ技术支持群:557445088
//
//  Created by 阳君 on 2017/6/5.
//  Copyright © 2017年 YJCocoa. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface YJLeakRetainCount : NSObject

@property (nonatomic) NSInteger currentRetainCount; ///< 当前引用计数retainCount
@property (nonatomic) NSInteger sumRetainCount;     ///< 总引用计数retainCount
@property (nonatomic, copy) NSString *className;    ///< 类名

@end

NS_ASSUME_NONNULL_END
