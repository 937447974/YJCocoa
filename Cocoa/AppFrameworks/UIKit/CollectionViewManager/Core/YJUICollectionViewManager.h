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
#import "YJUIScrollViewManager.h"

NS_ASSUME_NONNULL_BEGIN

/** CollectionViewManager的协议*/
@protocol YJUICollectionViewManagerDelegate <YJUICollectionViewCellProtocol, YJUIScrollViewManagerDelegate>

@optional

/**
 *  @abstract 用户点击整个Cell
 *  @discusstion 线程安全
 *
 *  @param cellObject    用户点击的cell数据
 *  @param tableViewCell 用户点击的Cell
 */
- (void)collectionViewManager:(YJUICollectionViewManager *)manager didSelectCellWithCellObject:(YJUICollectionCellObject *)cellObject;

@end

/** UICollectionView管理器*/
@interface YJUICollectionViewManager : NSObject

@property (nonatomic, strong) NSMutableArray<YJUICollectionCellObject *> *dataSource; ///< 数据源单一数组
@property (nonatomic, strong, readonly) NSMutableArray<NSMutableArray<YJUICollectionCellObject *> *> *dataSourceGrouped; ///< 数据源多数组

@property (nonatomic, weak, nullable) id<YJUICollectionViewManagerDelegate> delegate; ///< YJUITableViewManagerDelegate

@property (nonatomic, weak, readonly) UICollectionView *collectionView; ///< UICollectionView

@property (nonatomic, strong, readonly) YJUICollectionViewDataSourceManager *dataSourceManager; ///< YJUICollectionViewDataSourceManager
@property (nonatomic, strong, readonly) YJUICollectionViewDelegateFlowLayoutManager *delegateFlowLayoutManager; ///< YJUICollectionViewDelegateFlowLayoutManager
@property (nonatomic, strong, readonly) YJUIScrollViewManager *scrollViewManager; ///< YJUIScrollViewManager

/**
 *  @abstract 抽象的初始化接口,会自动填充设置collectionView.dataSource = self;collectionView.delegate = self.tableViewDelegate;
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
 */
- (void)addCollectionViewAOPDelegate:(id)delegate;

@end

NS_ASSUME_NONNULL_END
