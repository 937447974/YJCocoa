//
//  YJMemoryInfo.h
//  YJMemoryInfo
//
//  HomePage:https://github.com/937447974/YJCocoa
//  YJ技术支持群:557445088
//
//  Created by 阳君 on 2017/3/15.
//  Copyright © 2017年 YJCocoa. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

/** RAM相关信息*/
@interface YJMemoryInfo : NSObject

@property (nonatomic, readonly) CGFloat physicalMB; ///< 物理内存

@property (nonatomic, readonly) CGFloat freeMB;     ///< 空闲内存
@property (nonatomic, readonly) CGFloat inactiveMB; ///< 不活跃的，内存不足时抢占这部分内存
@property (nonatomic, readonly) CGFloat activeMB;   ///< 已使用静态分配内存，可分页
@property (nonatomic, readonly) CGFloat wireMB;     ///< 已使用动态分配内存，不可分页

@end

NS_ASSUME_NONNULL_END
