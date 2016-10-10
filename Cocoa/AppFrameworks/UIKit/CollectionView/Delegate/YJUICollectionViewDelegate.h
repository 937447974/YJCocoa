//
//  YJUICollectionViewDelegate.h
//  YJUICollectionView
//
//  HomePage:https://github.com/937447974/YJCocoa
//  YJ技术支持群:557445088
//
//  Created by 阳君 on 16/5/21.
//  Copyright © 2016年 YJCocoa. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class YJUICollectionCellObject, YJUICollectionViewDataSource;

/** 点击cell的block*/
typedef void (^ YJUICollectionViewCellBlock)(YJUICollectionCellObject *cellObject, UICollectionViewCell  * __nullable cell);


/** 缓存Size的策略*/
typedef NS_ENUM(NSInteger, YJUICollectionViewCacheSize) {
    YJUICollectionViewCacheSizeDefault,          ///< 根据相同的UITableViewCell类缓存高度
    YJUICollectionViewCacheSizeIndexPath,        ///< 根据NSIndexPath对应的位置缓存高度
    YJUICollectionViewCacheSizeClassAndIndexPath ///< 根据类名和NSIndexPath双重绑定缓存高度
};

/** UICollectionView滚动*/
typedef NS_OPTIONS(NSUInteger, YJUICollectionViewScroll) {
    YJUICollectionViewScrollEndTop,     ///< 滚动到顶部
    YJUICollectionViewScrollDidTop,     ///< 向上滚动
    YJUICollectionViewScrollWillTop,    ///< 将要向上滚动
    YJUICollectionViewScrollNone,       ///< 用户触摸，将要滚动
    YJUICollectionViewScrollWillBottom, ///< 将要向下滚动
    YJUICollectionViewScrollDidBottom,  ///< 向下滚动
    YJUICollectionViewScrollEndBottom   ///< 滚动到底部
};


/** cell的协议*/
@protocol YJUICollectionViewCellProtocol <NSObject>

@optional

/**
 *  用户点击Cell
 *
 *  @param cellObject    用户点击的cell数据
 *  @param tableViewCell 用户点击的Cell
 *
 *  @return void
 */
- (void)collectionViewDidSelectCellWithCellObject:(YJUICollectionCellObject *)cellObject collectionViewCell:(nullable UICollectionViewCell *)cell;

/**
 *  分页加载数据
 *
 *  @param cellObject 将要显示的Cell数据
 *  @param cell       将要显示的Cell
 *
 *  @return void
 */
- (void)collectionViewLoadingPageData:(YJUICollectionCellObject *)cellObject willDisplayCell:(UICollectionViewCell *)cell;

/**
 *  用户滚动UICollectionView
 *
 *  @param collectionView UICollectionView
 *  @param scroll YJUICollectionViewScroll
 *
 *  @return void
 */
- (void)collectionView:(UICollectionView *)collectionView scroll:(YJUICollectionViewScroll)scroll;

@end


/** UICollectionViewDelegate抽象接口*/
@interface YJUICollectionViewDelegate : NSObject <UICollectionViewDelegateFlowLayout>

@property (nonatomic) CGFloat scrollSpacingWill; ///< 将要滚动间隔，默认15
@property (nonatomic) CGFloat scrollSpacingDid;  ///< 已经滚动间隔，默认30

@property (nonatomic) BOOL isCacheSize;      ///< 是否缓存size，默认YES缓存，NO不缓存
@property (nonatomic) CGFloat lineItems;     ///< 一行显示多少个item
@property (nonatomic) BOOL itemHeightLayout; ///< item的高度是否根据宽度自适应（lineItems>0）
@property (nonatomic) YJUICollectionViewCacheSize cacheSizeStrategy; ///< 缓存高的策略。无须赋值，YJUICollectionViewDataSource抽象接口会根据cacheCellStrategy自动赋值

@property (nonatomic, weak, nullable) id <YJUICollectionViewCellProtocol> cellDelegate; ///< cell的代理
@property (nonatomic, copy, nullable) YJUICollectionViewCellBlock cellBlock;            ///< 点击cell的block

@property (nonatomic, weak, readonly) YJUICollectionViewDataSource *dataSource; ///< YJUICollectionViewDataSource

@property (nonatomic, weak, readonly) UICollectionViewFlowLayout *flowLayout; ///< 布局Layout

/**
 *  初始化
 *
 *  @param dataSource YJUICollectionViewDataSource数据源
 *
 *  @return YJUICollectionViewDelegate
 */
- (instancetype)initWithDataSource:(YJUICollectionViewDataSource *)dataSource;

/**
 *  UICollectionViewCell向VC发送数据
 *
 *  @param cellObject    用户点击的cell数据
 *  @param CollectionViewCell 用户点击的Cell
 *
 *  @return void
 */
- (void)sendVCWithCellObject:(YJUICollectionCellObject *)cellObject collectionViewCell:(nullable UICollectionViewCell *)cell;

/**
 *  清除所有缓存Size
 *
 *  @return void
 */
- (void)clearAllCacheSize;

@end

NS_ASSUME_NONNULL_END
