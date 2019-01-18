//
//  YJUIPageViewCell.h
//  PageViewManager
//
//  HomePage:https://github.com/937447974/YJCocoa
//  YJ技术支持群:557445088
//
//  Created by 阳君 on 2017/2/9.
//  Copyright © 2017年 YJCocoa. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YJUIPageViewCellObject.h"

NS_ASSUME_NONNULL_BEGIN

@class YJUIPageViewManager;

/** page cell 显示*/
typedef void(^ YJUIPageViewCellDidAppear)(NSInteger pageIndex);

/** PageView 的 cell 协议*/
@protocol YJUIPageViewCellProtocol <NSObject>

@optional

/**
 *  @abstract 获取YJUITableCellObject并自动填充模型。
 *
 *  @param cellModel 对应的Cell模型
 *
 *  @return YJUITableCellObject
 */
+ (YJUIPageViewCellObject *)cellObjectWithCellModel:(nullable id<YJUIPageViewCellModelProtocol>)cellModel;

/**
 *  @abstract 刷新 YJUIPageViewCell
 *
 *  @param cellObject       page封装的对象
 *  @param pageViewManager   YJUIPageViewManager
 */
- (void)reloadDataWithPageViewCellObject:(YJUIPageViewCellObject *)cellObject pageViewManager:(YJUIPageViewManager *)pageViewManager;

/**
 *  @abstract 设置界面显示回调
 *
 *  @param cellDidAppear YJUIPageViewCellDidAppear
 *
 */
- (void)setCellDidAppear:(YJUIPageViewCellDidAppear)cellDidAppear;

@end


/** PageView 的 cell 基类*/
@interface YJUIPageViewCell : UIViewController <YJUIPageViewCellProtocol>

@property (nonatomic, weak,) YJUIPageViewCellObject *cellObject;   ///< 封装的模型
@property (nonatomic, weak) YJUIPageViewManager *pageViewManager; ///< YJUIPageViewManager

@end

NS_ASSUME_NONNULL_END
