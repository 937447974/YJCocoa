//
//  YJUICollectionViewManager.h
//  YJCollectionView
//
//  HomePage:https://github.com/937447974/YJCocoa
//  YJ技术支持群:557445088
//
//  Created by 阳君 on 2016/10/18.
//  Copyright © 2016年 YJCocoa. All rights reserved.
//

#import "YJUICollectionViewDataSourceManager.h"
#import "YJUICollectionViewDelegateFlowLayoutManager.h"

NS_ASSUME_NONNULL_BEGIN

/** cell的协议*/
@protocol YJUICollectionViewManagerDelegate <YJUICollectionViewCellProtocol>

@optional

/**
 *  用户点击整个Cell
 *
 *  @param cellObject    用户点击的cell数据
 *  @param tableViewCell 用户点击的Cell
 *
 *  @return void
 */
- (void)collectionViewManager:(YJUICollectionViewManager *)manager didSelectCellWithCellObject:(YJUICollectionCellObject *)cellObject;

/**
 *  分页加载数据
 *
 *  @param manager YJUICollectionViewManager
 *
 *  @return void
 */
- (void)collectionViewManagerLoadingPageData:(YJUICollectionViewManager *)manager;

/**
 *  用户滚动UICollectionView
 *
 *  @param manager YJUICollectionViewManager
 *  @param scroll  YJUICollectionViewScroll
 *
 *  @return void
 */
- (void)collectionViewManager:(YJUICollectionViewManager *)manager scroll:(YJUICollectionViewScroll)scroll;

@end


@interface YJUICollectionViewManager : NSObject

@property (nonatomic, strong) NSMutableArray<YJUICollectionCellObject *> *dataSource; ///< 数据源单一数组
@property (nonatomic, strong, readonly) NSMutableArray<NSMutableArray<YJUICollectionCellObject *> *> *dataSourceGrouped; ///< 数据源多数组

@property (nonatomic, weak, nullable) id<YJUICollectionViewManagerDelegate> delegate; ///< YJUITableViewManagerDelegate

@property (nonatomic, weak, readonly) UICollectionView *collectionView; ///< UICollectionView

@property (nonatomic, strong, readonly) YJUICollectionViewDataSourceManager *dataSourceManager; ///< YJUICollectionViewDataSourceManager
@property (nonatomic, strong, readonly) YJUICollectionViewDelegateFlowLayoutManager *delegateFlowLayoutManager; ///< YJUICollectionViewDelegateFlowLayoutManager

/**
 *  抽象的初始化接口,会自动填充设置collectionView.dataSource = self;collectionView.delegate = self.tableViewDelegate;
 *
 *  @param collectionView UICollectionView
 *
 *  @return YJUICollectionViewDataSource
 */
- (instancetype)initWithCollectionView:(UICollectionView *)collectionView;

/**
 *  @abstract 添加UICollectionView的AOP代理
 *  @discusstion VC想实现UICollectionViewDataSource和UICollectionViewDelegate时，又不想替换框架中的方法，可通过此方法添加
 *
 *  @param delegate id<UICollectionViewDataSource, UICollectionViewDelegate>
 *
 *  @return void
 */
- (void)addCollectionViewAOPDelegate:(id)delegate;

@end

NS_ASSUME_NONNULL_END
