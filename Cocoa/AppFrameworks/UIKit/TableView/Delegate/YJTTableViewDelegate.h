//
//  YJTTableViewDelegate.h
//  YJTTableViewFactory
//
//  HomePage:https://github.com/937447974/YJCocoa
//  YJ技术支持群:557445088
//
//  Created by 阳君 on 16/3/26.
//  Copyright © 2016年 YJCocoa. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YJTSuspensionCellView.h"

NS_ASSUME_NONNULL_BEGIN

@class YJTTableCellObject, YJTTableViewDataSource;


/** 缓存高的策略*/
typedef NS_ENUM(NSInteger, YJTTableViewCacheHeight) {
    YJTTableViewCacheHeightDefault,          ///< 根据相同的UITableViewCell类缓存高度
    YJTTableViewCacheHeightIndexPath,        ///< 根据NSIndexPath对应的位置缓存高度
    YJTTableViewCacheHeightClassAndIndexPath ///< 根据类名和NSIndexPath双重绑定缓存高度
};

/** UITableView滚动*/
typedef NS_OPTIONS(NSUInteger, YJTTableViewScroll) {
    YJTTableViewScrollEndTop,     ///< 滚动到顶部
    YJTTableViewScrollDidTop,     ///< 向上滚动
    YJTTableViewScrollWillTop,    ///< 将要向上滚动
    YJTTableViewScrollNone,       ///< 用户触摸，将要滚动
    YJTTableViewScrollWillBottom, ///< 将要向下滚动
    YJTTableViewScrollDidBottom,  ///< 向下滚动
    YJTTableViewScrollEndBottom   ///< 滚动到底部
};


/** 点击cell的block*/
typedef void (^ YJTTableViewCellBlock)(YJTTableCellObject *cellObject, UITableViewCell  * __nullable tableViewCell);

/** cell的协议*/
@protocol YJTTableViewCellProtocol <NSObject>

@optional

/**
 *  用户点击Cell
 *
 *  @param cellObject    用户点击的cell数据
 *  @param tableViewCell 用户点击的Cell
 *
 *  @return void
 */
- (void)tableViewDidSelectCellWithCellObject:(YJTTableCellObject *)cellObject tableViewCell:(nullable UITableViewCell *)cell;

/**
 *  分页加载数据
 *
 *  @param cellObject 将要显示的Cell数据
 *  @param cell       将要显示的Cell
 *
 *  @return void
 */
- (void)tableViewLoadingPageData:(YJTTableCellObject *)cellObject willDisplayCell:(UITableViewCell *)cell;

/**
 *  用户滚动UICollectionView
 *
 *  @param tableView UITableView
 *  @param scroll YJTTableViewScroll
 *
 *  @return void
 */
- (void)tableView:(UITableView *)tableView scroll:(YJTTableViewScroll)scroll;

@end


/** UITableViewDelegate抽象接口*/
@interface YJTTableViewDelegate : NSObject <UITableViewDelegate>

@property (nonatomic) CGFloat scrollSpacingWill; ///< 将要滚动间隔，默认15
@property (nonatomic) CGFloat scrollSpacingDid;  ///< 已经滚动间隔，默认30

@property (nonatomic) BOOL isCacheHeight;                         ///< 是否缓存高，默认YES缓存，NO不缓存
@property (nonatomic) YJTTableViewCacheHeight cacheHeightStrategy; ///< 缓存高的策略。无须赋值，YJTTableViewDataSource抽象接口会根据cacheCellStrategy自动赋值

@property (nonatomic, weak, nullable) id <YJTTableViewCellProtocol> cellDelegate; ///< cell的代理
@property (nonatomic, copy, nullable) YJTTableViewCellBlock cellBlock;            ///< 点击cell的block

@property (nonatomic, weak, readonly) YJTTableViewDataSource *dataSource; ///< YJTTableViewDataSource

@property (nonatomic, strong) YJTSuspensionCellView *suspensionCellView; ///< 悬浮的cell层

/**
 *  初始化
 *
 *  @param dataSource YJTTableViewDataSource数据源
 *
 *  @return YJTTableViewDelegate
 */
- (instancetype)initWithDataSource:(YJTTableViewDataSource *)dataSource;

/**
 *  UITableViewCell向VC发送数据
 *
 *  @param cellObject    用户点击的cell数据
 *  @param tableViewCell 用户点击的Cell
 *
 *  @return void
 */
- (void)sendVCWithCellObject:(YJTTableCellObject *)cellObject tableViewCell:(nullable UITableViewCell *)cell;

/**
 *  清除所有缓存高
 *
 *  @return void
 */
- (void)clearAllCacheHeight;

/**
 *  根据cellObject清楚缓存高
 *
 *  @param cellObject YJTTableCellObject
 *
 *  @return void
 */
- (void)clearCacheHeightWithCellObject:(YJTTableCellObject *)cellObject;

/**
 *  根据多个cellObject清楚缓存高
 *
 *  @param cellObject YJTTableCellObject
 *
 *  @return void
 */
- (void)clearCacheHeightWithCellObjects:(NSArray<YJTTableCellObject *> *)cellObjects;

@end

NS_ASSUME_NONNULL_END
