//
//  YJUICollectionViewDataSourceManager.m
//  YJCollectionView
//
//  HomePage:https://github.com/937447974/YJCocoa
//  YJ技术支持群:557445088
//
//  Created by 阳君 on 2016/10/18.
//  Copyright © 2016年 YJCocoa. All rights reserved.
//

#import "YJUICollectionViewDataSourceManager.h"
#import "YJUICollectionViewManager.h"

@interface YJUICollectionViewDataSourceManager ()

@property (nonatomic, strong) NSMutableSet<NSString *> *identifierSet; ///< 记录缓存过的identifier

@end

@implementation YJUICollectionViewDataSourceManager

- (instancetype)initWithManager:(YJUICollectionViewManager *)manager {
    self = [super init];
    if (self) {
        _manager = manager;
        self.identifierSet = [NSMutableSet set];
        self.headerDataSource = [NSMutableArray array];
        self.footerDataSource = [NSMutableArray array];
    }
    return self;
}

#pragma mark 快速刷新已加载cell
- (void)reloadItemsAtCellObjects:(NSArray<YJUICollectionCellObject *> *)cellObjects; {
    UICollectionViewCell *cell;
    for (YJUICollectionCellObject *cellObject in cellObjects) {
        cell = [self.manager.collectionView cellForItemAtIndexPath:cellObject.indexPath];
        [cell reloadDataWithCellObject:cellObject collectionViewManager:self.manager];
    }
}

- (UICollectionViewCell *)dequeueReusableCellWithCellObject:(YJUICollectionCellObject *)cellObject {
    NSString *identifier = cellObject.cellName;
    // 判断是否缓存
    if (![self.identifierSet containsObject:identifier]) {
        switch (cellObject.createCell) {
                case YJUICollectionCellCreateClass: // 使用Class创建cell，即使用[[UICollectionViewCell alloc] initWithFrame:CGRectZero]创建cell
                [self.manager.collectionView registerClass:cellObject.cellClass forCellWithReuseIdentifier:identifier];
                break;
                case YJUICollectionCellCreateXib: // 默认使用xib创建cell，推荐此方式
                [self.manager.collectionView registerNib:[UINib nibWithNibName:cellObject.cellName bundle:nil] forCellWithReuseIdentifier:identifier];
                break;
                case YJUICollectionCellCreateStoryboard: // 使用soryboard创建cell时，请使用类名作为标识符
                // Soryboard中设置UICollectionViewCell类名作为Identifier
                identifier = cellObject.cellName;
                break;
        }
        [self.identifierSet addObject:identifier];
    }
    // 读取缓存
    UICollectionViewCell *cell = [self.manager.collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:cellObject.indexPath];
    // 刷新数据
    [cell reloadDataWithCellObject:cellObject collectionViewManager:self.manager];
    return cell;
}

#pragma mark - UICollectionViewDataSource
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return self.manager.dataSourceGrouped.count;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    if (_manager.dataSourceGrouped.count <= section) {
        NSLog(@"error:数组越界; selector:%@", NSStringFromSelector(_cmd));
        return 0;
    }
    return self.manager.dataSourceGrouped[section].count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    YJUICollectionCellObject *cellObject;
    if (_manager.dataSourceGrouped.count <= indexPath.section || _manager.dataSourceGrouped[indexPath.section].count <= indexPath.item) {
        NSLog(@"error:数组越界; selector:%@", NSStringFromSelector(_cmd));
        cellObject = [YJUICollectionViewCell cellObject];
    } else {
        cellObject = self.manager.dataSourceGrouped[indexPath.section][indexPath.item];
    }
    cellObject.indexPath = indexPath;
    UICollectionViewCell *cell = [self dequeueReusableCacheCellWithCellObject:cellObject];
    return cell;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    YJUICollectionCellObject *cellObject;
    NSArray *dataSource = [UICollectionElementKindSectionHeader isEqualToString:kind] ? self.headerDataSource : self.footerDataSource;
    if (dataSource.count <= indexPath.section) {
        NSLog(@"error:数组越界; selector:%@", NSStringFromSelector(_cmd));
        cellObject = [YJUICollectionReusableView cellObject];
    } else {
        cellObject = dataSource[indexPath.section];
    }
    cellObject.indexPath = indexPath;
    // 判断是否缓存
    NSString *identifier = [NSString stringWithFormat:@"%@-%@", kind, cellObject.cellName];
    if (![self.identifierSet containsObject:identifier]) {
        switch (cellObject.createCell) {
                case YJUICollectionCellCreateClass: // 使用Class创建cell，即使用[[UICollectionReusableView alloc] initWithFrame:CGRectZero]创建cell
                [self.manager.collectionView registerClass:cellObject.cellClass forSupplementaryViewOfKind:kind withReuseIdentifier:identifier];
                break;
                case YJUICollectionCellCreateXib: // 默认使用xib创建cell，推荐此方式
                [self.manager.collectionView registerNib:[UINib nibWithNibName:cellObject.cellName bundle:nil]  forSupplementaryViewOfKind:kind withReuseIdentifier:identifier];
                break;
                case YJUICollectionCellCreateStoryboard: // 使用soryboard创建cell时，请使用类名作为标识符
                // Soryboard中设置UICollectionViewCell类名作为Identifier
                identifier = cellObject.cellName;
                break;
        }
        [self.identifierSet addObject:identifier];
    }
    // 读取缓存
    UICollectionReusableView *rv = [self.manager.collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:identifier forIndexPath:indexPath];
    // 刷新数据
    [rv reloadDataWithCellObject:cellObject collectionViewManager:self.manager];
    // 指向
    if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
        _collectionHeaderView = rv;
    } else {
        _collectionFooterView = rv;
    }
    return rv;
}

@end
