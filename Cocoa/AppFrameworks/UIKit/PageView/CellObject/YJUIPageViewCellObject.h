//
//  YJUIPageViewCellObject.h
//  YJPageView
//
//  HomePage:https://github.com/937447974/YJCocoa
//  YJ技术支持群:557445088
//
//  Created by 阳君 on 2017/2/9.
//  Copyright © 2017年 YJ. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

/** PageViewCell的数据模型协议*/
@protocol YJUIPageViewCellModelProtocol <NSObject>

@end

/** pageViewCell对应的模型封装*/
@interface YJUIPageViewCellObject : NSObject

@property (nonatomic) __kindof id<YJUIPageViewCellModelProtocol> cellModel; ///< PageViewCell对应的VM
@property (nonatomic, strong, nullable) id userInfo;                        ///< 携带的数据

@property (nonatomic) NSInteger pageIndex;       ///< 当前页码，无须添加，自动填充
@property (nonatomic, readonly) Class pageClass; ///< PageView对应的类

/**
 *  初始化YJUIPageViewObject
 *
 *  @param pageClass YJUIPageViewController对应的类
 *
 *  @return YJUIPageViewObject
 */
- (instancetype)initWithPageClass:(Class)pageClass;

@end

NS_ASSUME_NONNULL_END
