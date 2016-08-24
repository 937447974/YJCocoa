//
//  YJTLayoutSupport.h
//  YJAutoLayout
//
//  HomePage:https://github.com/937447974/YJCocoa
//  YJ技术支持群:557445088
//
//  Created by 阳君 on 16/4/23.
//  Copyright © 2016年 YJCocoa. All rights reserved.
//

#import "YJTLayoutYAxisAnchor.h"

/** 仿UILayoutSupport*/
NS_CLASS_AVAILABLE_IOS(7_0)
@interface YJTLayoutSupport : NSObject

/* Constraint creation conveniences. See YJTLayoutAnchor.h for details.
 */
@property (nonatomic, strong, readonly) YJTLayoutYAxisAnchor *topLayout;    ///< 替换topAnchor
@property (nonatomic, strong, readonly) YJTLayoutYAxisAnchor *bottomLayout; ///< 替换bottomAnchor

/**
 *  初始化YJTLayoutSupport
 *
 *  @param layoutGuide topLayoutGuide/bottomLayoutGuide
 *
 *  @return instancetype
 */
- (instancetype)initWithItem:(id<UILayoutSupport>)layoutGuide;

@end
