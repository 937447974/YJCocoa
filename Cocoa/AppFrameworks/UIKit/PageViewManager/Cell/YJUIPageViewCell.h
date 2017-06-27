//
//  YJUIPageViewCell.h
//  PageViewManager
//
//  HomePage:https://github.com/937447974/YJCocoa
//  YJ技术支持群:557445088
//
//  Created by 阳君 on 2017/2/9.
//  Copyright © 2017年 YJ. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YJUIPageViewCellObject.h"

NS_ASSUME_NONNULL_BEGIN

@class YJUIPageViewManager;

/** PageView的cell基类*/
@interface YJUIPageViewCell : UIViewController

@property (nonatomic, weak, readonly) YJUIPageViewCellObject *cellObject;   ///< 封装的模型
@property (nonatomic, weak, readonly) YJUIPageViewManager *pageViewManager; ///< YJUIPageViewManager

/**
 *  @abstract 获取YJUITableCellObject并自动填充模型。
 *
 *  @param cellModel 对应的Cell模型
 *
 *  @return YJUITableCellObject
 */
+ (YJUIPageViewCellObject *)cellObjectWithCellModel:(nullable id<YJUIPageViewCellModelProtocol>)cellModel;

/**
 *  @abstract 初始化
 *
 *  @return YJUIPageViewCell
 */
- (instancetype)initPageView;

/**
 *  @abstract 刷新 YJUIPageViewCell
 *
 *  @param cellObject       page封装的对象
 *  @param pageViewManager   YJUIPageViewManager
 */
- (void)reloadDataWithPageViewCellObject:(YJUIPageViewCellObject *)cellObject pageViewManager:(YJUIPageViewManager *)pageViewManager;

@end

NS_ASSUME_NONNULL_END
