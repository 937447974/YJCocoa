//
//  YJUIPageViewCell.h
//  YJPageView
//
//  HomePage:https://github.com/937447974/YJCocoa
//  YJ技术支持群:557445088
//
//  Created by 阳君 on 2017/2/9.
//  Copyright © 2017年 YJ. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YJUIPageViewCellObject.h"

@class YJUIPageView;

/** PageView的cell基类*/
@interface YJUIPageViewCell : UIViewController

@property (nonatomic, weak, readonly) YJUIPageViewCellObject *cellObject; ///< 封装的模型
@property (nonatomic, weak, readonly) YJUIPageView *pageView;             ///< YJUIPageView

/**
 *  获取YJUITableCellObject并自动填充模型。
 *
 *  @param cellModel 对应的Cell模型
 *
 *  @return YJUITableCellObject
 */
+ (YJUIPageViewCellObject *)cellObjectWithCellModel:(id<YJUIPageViewCellModelProtocol>)cellModel;

/**
 *  @abstract 初始化
 *
 *  @return YJUIPageViewCell
 */
- (instancetype)initPageView;

/**
 *  刷新page
 *
 *  @param cellObject page封装的对象
 *  @param pageView   YJUIPageView
 */
- (void)reloadDataWithPageViewCellObject:(YJUIPageViewCellObject *)cellObject pageView:(YJUIPageView *)pageView;

@end
