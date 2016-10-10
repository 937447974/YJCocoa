//
//  YJTCollectionViewDelegate.h
//  YJTCollectionView
//
//  HomePage:https://github.com/937447974/YJCocoa
//  YJ技术支持群:557445088
//
//  Created by 阳君 on 16/5/21.
//  Copyright © 2016年 YJCocoa. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class YJTCollectionCellObject, YJTCollectionViewDataSource;

/** 点击cell的block*/
typedef void (^ YJTCollectionViewCellBlock)(YJTCollectionCellObject *cellObject, UICollectionViewCell  * __nullable cell);


/** 缓存Size的策略*/
typedef NS_ENUM(NSInteger, YJTCollectionViewCacheSize) {
    YJTCollectionViewCacheSizeDefault,          ///< 根据相同的UITableViewCell类缓存高度
    YJTCollectionViewCacheSizeIndexPath,        ///< 根据NSIndexPath对应的位置缓存高度
    YJTCollectionViewCacheSizeClassAndIndexPath ///< 根据类名和NSIndexPath双重绑定缓存高度
};

/** UICollectionView滚动*/
typedef NS_OPTIONS(NSUInteger, YJTCollectionViewScroll) {
    YJTCollectionViewScrollEndTop,     ///< 滚动到顶部
    YJTCollectionViewScrollDidTop,     ///< 向上滚动
    YJTCollectionViewScrollWillTop,    ///< 将要向上滚动
    YJTCollectionViewScrollNone,       ///< 用户触摸，将要滚动
    YJTCollectionViewScrollWillBottom, ///< 将要向下滚动
    YJTCollectionViewScrollDidBottom,  ///< 向下滚动
    YJTCollectionViewScrollEndBottom   ///< 滚动到底部
};


/** cell的协议*/
@protocol YJTCollectionViewCellProtocol <NSObject>

@optional

/**
 *  用户点击Cell
 *
 *  @param cellObject    用户点击的cell数据
 *  @param tableViewCell 用户点击的Cell
 *
 *  @return void
 */
- (void)collectionViewDidSelectCellWithCellObject:(YJTCollectionCellObject *)cellObject collectionViewCell:(nullable UICollectionViewCell *)cell;

/**
 *  分页加载数据
 *
 *  @param cellObject 将要显示的Cell数据
 *  @param cell       将要显示的Cell
 *
 *  @return void
 */
- (void)collectionViewLoadingPageData:(YJTCollectionCellObject *)cellObject willDisplayCell:(UICollectionViewCell *)cell;

/**
 *  用户滚动UICollectionView
 *
 *  @param collectionView UICollectionView
 *  @param scroll YJTCollectionViewScroll
 *
 *  @return void
 */
- (void)collectionView:(UICollectionView *)collectionView scroll:(YJTCollectionViewScroll)scroll;

@end


/** UICollectionViewDelegate抽象接口*/
@interface YJTCollectionViewDelegate : NSObject <UICollectionViewDelegateFlowLayout>

@property (nonatomic) CGFloat scrollSpacingWill; ///< 将要滚动间隔，默认15
@property (nonatomic) CGFloat scrollSpacingDid;  ///< 已经滚动间隔，默认30

@property (nonatomic) BOOL isCacheSize;      ///< 是否缓存size，默认YES缓存，NO不缓存
@property (nonatomic) CGFloat lineItems;     ///< 一行显示多少个item
@property (nonatomic) BOOL itemHeightLayout; ///< item的高度是否根据宽度自适应（lineItems>0）
@property (nonatomic) YJTCollectionViewCacheSize cacheSizeStrategy; ///< 缓存高的策略。无须赋值，YJTCollectionViewDataSource抽象接口会根据cacheCellStrategy自动赋值

@property (nonatomic, weak, nullable) id <YJTCollectionViewCellProtocol> cellDelegate; ///< cell的代理
@property (nonatomic, copy, nullable) YJTCollectionViewCellBlock cellBlock;            ///< 点击cell的block

@property (nonatomic, weak, readonly) YJTCollectionViewDataSource *dataSource; ///< YJTCollectionViewDataSource

@property (nonatomic, weak, readonly) UICollectionViewFlowLayout *flowLayout; ///< 布局Layout

/**
 *  初始化
 *
 *  @param dataSource YJTCollectionViewDataSource数据源
 *
 *  @return YJTCollectionViewDelegate
 */
- (instancetype)initWithDataSource:(YJTCollectionViewDataSource *)dataSource;

/**
 *  UICollectionViewCell向VC发送数据
 *
 *  @param cellObject    用户点击的cell数据
 *  @param CollectionViewCell 用户点击的Cell
 *
 *  @return void
 */
- (void)sendVCWithCellObject:(YJTCollectionCellObject *)cellObject collectionViewCell:(nullable UICollectionViewCell *)cell;

/**
 *  清除所有缓存Size
 *
 *  @return void
 */
- (void)clearAllCacheSize;

@end

NS_ASSUME_NONNULL_END