//
//  YJUIPageViewCellObject.h
//  PageViewManager
//
//  HomePage:https://github.com/937447974/YJCocoa
//  YJ技术支持群:557445088
//
//  Created by 阳君 on 2017/2/9.
//  Copyright © 2017年 YJCocoa. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

/** pageViewCell对应的模型封装*/
@interface YJUIPageViewCellObject : NSObject

@property (nonatomic, strong) id cellModel; ///< PageViewCell对应的VM

@property (nonatomic) NSInteger pageIndex;       ///< 当前页码
@property (nonatomic, readonly) Class pageClass; ///< PageView对应的类

/**
 *  @abstract 初始化YJUIPageViewObject
 *
 *  @param pageClass YJUIPageViewController对应的类
 *
 *  @return YJUIPageViewObject
 */
- (instancetype)initWithPageClass:(Class)pageClass;

@end

NS_ASSUME_NONNULL_END
