//
//  YJCollectionViewDelegate.h
//  YJCollectionView
//
//  HomePage:https://github.com/937447974/YJCocoa
//  YJ技术支持群:557445088
//
//  Created by 阳君 on 16/5/21.
//  Copyright © 2016年 YJ. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class YJCollectionCellObject, YJCollectionViewDataSource;

/** 点击cell的block*/
typedef void (^ YJCollectionViewCellBlock)(YJCollectionCellObject *cellObject, UICollectionViewCell  * __nullable cell);


/** 缓存Size的策略*/
typedef NS_ENUM(NSInteger, YJCollectionViewCacheSize) {
    YJCollectionViewCacheSizeDefault,          ///< 根据相同的UITableViewCell类缓存高度
    YJCollectionViewCacheSizeIndexPath,        ///< 根据NSIndexPath对应的位置缓存高度
    YJCollectionViewCacheSizeClassAndIndexPath ///< 根据类名和NSIndexPath双重绑定缓存高度
};

/** UICollectionView滚动*/
typedef NS_OPTIONS(NSUInteger, YJCollectionViewScroll) {
    YJCollectionViewScrollEndTop,     ///< 滚动到顶部
    YJCollectionViewScrollDidTop,     ///< 向上滚动
    YJCollectionViewScrollWillTop,    ///< 将要向上滚动
    YJCollectionViewScrollNone,       ///< 用户触摸，将要滚动
    YJCollectionViewScrollWillBottom, ///< 将要向下滚动
    YJCollectionViewScrollDidBottom   ///< 向下滚动
};


/** cell的协议*/
@protocol YJCollectionViewCellProtocol <NSObject>

@optional

/**
 *  用户点击Cell
 *
 *  @param cellObject    用户点击的cell数据
 *  @param tableViewCell 用户点击的Cell
 *
 *  @return void
 */
- (void)collectionViewDidSelectCellWithCellObject:(YJCollectionCellObject *)cellObject collectionViewCell:(nullable UICollectionViewCell *)cell;

/**
 *  分页加载数据
 *
 *  @param cellObject 将要显示的Cell数据
 *  @param cell       将要显示的Cell
 *
 *  @return void
 */
- (void)collectionViewLoadingPageData:(YJCollectionCellObject *)cellObject willDisplayCell:(UICollectionViewCell *)cell;

/**
 *  用户滚动UICollectionView
 *
 *  @param collectionView UICollectionView
 *  @param scroll YJCollectionViewScroll
 *
 *  @return void
 */
- (void)collectionView:(UICollectionView *)collectionView scroll:(YJCollectionViewScroll)scroll;

@end


/** UICollectionViewDelegate抽象接口*/
@interface YJCollectionViewDelegate : NSObject <UICollectionViewDelegateFlowLayout>

@property (nonatomic) CGFloat scrollSpacingWill; ///< 将要滚动间隔，默认15
@property (nonatomic) CGFloat scrollSpacingDid;  ///< 已经滚动间隔，默认30

@property (nonatomic) BOOL isCacheSize;      ///< 是否缓存高，默认YES缓存，NO不缓存
@property (nonatomic) CGFloat lineItems;     ///< 一行显示多少个item
@property (nonatomic) BOOL itemHeightLayout; ///< item的高度是否根据宽度自适应（lineItems>0）
@property (nonatomic) YJCollectionViewCacheSize cacheSizeStrategy; ///< 缓存高的策略。无须赋值，YJCollectionViewDataSource抽象接口会根据cacheCellStrategy自动赋值

@property (nonatomic, weak, nullable) id <YJCollectionViewCellProtocol> cellDelegate; ///< cell的代理
@property (nonatomic, copy, nullable) YJCollectionViewCellBlock cellBlock;            ///< 点击cell的block

@property (nonatomic, weak, readonly) YJCollectionViewDataSource *dataSource; ///< YJCollectionViewDataSource

@property (nonatomic, weak, readonly) UICollectionViewFlowLayout *flowLayout; ///< 布局Layout

/**
 *  初始化
 *
 *  @param dataSource YJCollectionViewDataSource数据源
 *
 *  @return YJCollectionViewDelegate
 */
- (instancetype)initWithDataSource:(YJCollectionViewDataSource *)dataSource;

/**
 *  UICollectionViewCell向VC发送数据
 *
 *  @param cellObject    用户点击的cell数据
 *  @param CollectionViewCell 用户点击的Cell
 *
 *  @return void
 */
- (void)sendVCWithCellObject:(YJCollectionCellObject *)cellObject collectionViewCell:(nullable UICollectionViewCell *)cell;

/**
 *  清除所有缓存Size
 *
 *  @return void
 */
- (void)clearAllCacheSize;

@end

NS_ASSUME_NONNULL_END