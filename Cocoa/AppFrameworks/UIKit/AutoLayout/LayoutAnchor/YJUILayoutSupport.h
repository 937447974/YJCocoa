//
//  YJUILayoutSupport.h
//  YJAutoLayout
//
//  HomePage:https://github.com/937447974/YJCocoa
//  YJ技术支持群:557445088
//
//  Created by 阳君 on 16/4/23.
//  Copyright © 2016年 YJCocoa. All rights reserved.
//

#import "YJNSLayoutYAxisAnchor.h"

NS_ASSUME_NONNULL_BEGIN

/** 仿UILayoutSupport*/
NS_CLASS_AVAILABLE_IOS(7_0)
@interface YJUILayoutSupport : NSObject

/* Constraint creation conveniences. See UILayoutAnchor.h for details.
 */
@property (nonatomic, strong, readonly) YJNSLayoutYAxisAnchor *topLayout;    ///< 替换topAnchor
@property (nonatomic, strong, readonly) YJNSLayoutYAxisAnchor *bottomLayout; ///< 替换bottomAnchor

/**
 *  @abstract 初始化YJUILayoutSupport
 *
 *  @param layoutGuide topLayoutGuide/bottomLayoutGuide
 *
 *  @return instancetype
 */
- (instancetype)initWithItem:(id<UILayoutSupport>)layoutGuide;

@end

NS_ASSUME_NONNULL_END
