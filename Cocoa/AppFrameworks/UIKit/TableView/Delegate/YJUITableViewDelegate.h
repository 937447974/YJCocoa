//
//  YJUITableViewDelegate.h
//  YJUITableViewFactory
//
//  HomePage:https://github.com/937447974/YJCocoa
//  YJ技术支持群:557445088
//
//  Created by 阳君 on 16/3/26.
//  Copyright © 2016年 YJCocoa. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YJUISuspensionCellView.h"

NS_ASSUME_NONNULL_BEGIN

@class YJUITableCellObject, YJUITableViewDataSource;


/** 缓存高的策略*/
typedef NS_ENUM(NSInteger, YJUITableViewCacheHeight) {
    YJUITableViewCacheHeightDefault,          ///< 根据相同的UITableViewCell类缓存高度
    YJUITableViewCacheHeightIndexPath,        ///< 根据NSIndexPath对应的位置缓存高度
    YJUITableViewCacheHeightClassAndIndexPath ///< 根据类名和NSIndexPath双重绑定缓存高度
};

/** UITableView滚动*/
typedef NS_OPTIONS(NSUInteger, YJUITableViewScroll) {
    YJUITableViewScrollEndTop,     ///< 滚动到顶部
    YJUITableViewScrollDidTop,     ///< 向上滚动
    YJUITableViewScrollWillTop,    ///< 将要向上滚动
    YJUITableViewScrollNone,       ///< 用户触摸，将要滚动
    YJUITableViewScrollWillBottom, ///< 将要向下滚动
    YJUITableViewScrollDidBottom,  ///< 向下滚动
    YJUITableViewScrollEndBottom   ///< 滚动到底部
};


/** 点击cell的block*/
typedef void (^ YJUITableViewCellBlock)(YJUITableCellObject *cellObject, UITableViewCell  * __nullable tableViewCell);

/** cell的协议*/
@protocol YJUITableViewCellProtocol <NSObject>

@optional

/**
 *  用户点击Cell
 *
 *  @param cellObject    用户点击的cell数据
 *  @param tableViewCell 用户点击的Cell
 *
 *  @return void
 */
- (void)tableViewDidSelectCellWithCellObject:(YJUITableCellObject *)cellObject tableViewCell:(nullable UITableViewCell *)cell;

/**
 *  分页加载数据
 *
 *  @param cellObject 将要显示的Cell数据
 *  @param cell       将要显示的Cell
 *
 *  @return void
 */
- (void)tableViewLoadingPageData:(YJUITableCellObject *)cellObject willDisplayCell:(UITableViewCell *)cell;

/**
 *  用户滚动UICollectionView
 *
 *  @param tableView UITableView
 *  @param scroll YJUITableViewScroll
 *
 *  @return void
 */
- (void)tableView:(UITableView *)tableView scroll:(YJUITableViewScroll)scroll;

@end


/** UITableViewDelegate抽象接口*/
@interface YJUITableViewDelegate : NSObject <UITableViewDelegate>

@property (nonatomic) CGFloat scrollSpacingWill; ///< 将要滚动间隔，默认15
@property (nonatomic) CGFloat scrollSpacingDid;  ///< 已经滚动间隔，默认30

@property (nonatomic) BOOL isCacheHeight;                         ///< 是否缓存高，默认YES缓存，NO不缓存
@property (nonatomic) YJUITableViewCacheHeight cacheHeightStrategy; ///< 缓存高的策略。无须赋值，YJUITableViewDataSource抽象接口会根据cacheCellStrategy自动赋值

@property (nonatomic, weak, nullable) id <YJUITableViewCellProtocol> cellDelegate; ///< cell的代理
@property (nonatomic, copy, nullable) YJUITableViewCellBlock cellBlock;            ///< 点击cell的block

@property (nonatomic, weak, readonly) YJUITableViewDataSource *dataSource; ///< YJUITableViewDataSource

@property (nonatomic, strong) YJUISuspensionCellView *suspensionCellView; ///< 悬浮的cell层

/**
 *  初始化
 *
 *  @param dataSource YJUITableViewDataSource数据源
 *
 *  @return YJUITableViewDelegate
 */
- (instancetype)initWithDataSource:(YJUITableViewDataSource *)dataSource;

/**
 *  UITableViewCell向VC发送数据
 *
 *  @param cellObject    用户点击的cell数据
 *  @param tableViewCell 用户点击的Cell
 *
 *  @return void
 */
- (void)sendVCWithCellObject:(YJUITableCellObject *)cellObject tableViewCell:(nullable UITableViewCell *)cell;

/**
 *  清除所有缓存高
 *
 *  @return void
 */
- (void)clearAllCacheHeight;

/**
 *  根据cellObject清楚缓存高
 *
 *  @param cellObject YJUITableCellObject
 *
 *  @return void
 */
- (void)clearCacheHeightWithCellObject:(YJUITableCellObject *)cellObject;

/**
 *  根据多个cellObject清楚缓存高
 *
 *  @param cellObject YJUITableCellObject
 *
 *  @return void
 */
- (void)clearCacheHeightWithCellObjects:(NSArray<YJUITableCellObject *> *)cellObjects;

@end

NS_ASSUME_NONNULL_END
