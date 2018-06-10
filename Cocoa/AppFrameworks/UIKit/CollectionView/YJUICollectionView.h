//
//  YJUICollectionView.h
//  YJCocoa
//
//  HomePage:https://github.com/937447974/YJCocoa
//  YJ技术支持群:557445088
//
//  Created by 阳君 on 2018/6/9.
//  Copyright © 2016年 YJCocoa. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YJUICollectionViewManager.h"

NS_ASSUME_NONNULL_BEGIN

/** UICollectionView*/
@interface YJUICollectionView : UICollectionView

@property (nonatomic, strong) NSMutableArray<YJUICollectionCellObject *> *dataSourcePlain; ///< 数据源单一数组
@property (nonatomic, strong) NSMutableArray<NSMutableArray<YJUICollectionCellObject *> *> *dataSourceGrouped; ///< 数据源多数组

@property (nonatomic, strong) NSMutableArray<YJUICollectionCellObject *> *dataSourceHeader; ///< SectionHeader数据源
@property (nonatomic, strong) NSMutableArray<YJUICollectionCellObject *> *dataSourceFooter; ///< SectionFooter数据源

@property (nonatomic, strong, readonly) YJUICollectionViewManager *manager; ///< 管理器

@end

NS_ASSUME_NONNULL_END
