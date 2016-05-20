//
//  YJLayoutSupport.h
//  YJAutoLayout
//
//  HomePage:https://github.com/937447974/YJCocoa
//  YJ技术支持群:557445088
//
//  Created by 阳君 on 16/4/23.
//  Copyright © 2016年 YJ. All rights reserved.
//

#import "YJLayoutYAxisAnchor.h"

/** 仿UILayoutSupport*/
NS_CLASS_AVAILABLE_IOS(7_0)
@interface YJLayoutSupport : NSObject

/* Constraint creation conveniences. See YJLayoutAnchor.h for details.
 */
@property (nonatomic, strong, readonly) YJLayoutYAxisAnchor *topLayout; ///< 替换topAnchor
@property (nonatomic, strong, readonly) YJLayoutYAxisAnchor *bottomLayout; ///< 替换bottomAnchor

/**
 *  初始化YJLayoutSupport
 *
 *  @param layoutGuide topLayoutGuide/bottomLayoutGuide
 *
 *  @return instancetype
 */
- (instancetype)initWithItem:(id<UILayoutSupport>)layoutGuide;

@end
