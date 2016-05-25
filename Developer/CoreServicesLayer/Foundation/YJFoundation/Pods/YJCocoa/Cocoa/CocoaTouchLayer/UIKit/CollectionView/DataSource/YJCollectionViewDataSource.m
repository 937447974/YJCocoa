//
//  YJCollectionViewDataSource.m
//  YJCollectionView
//
//  Created by 阳君 on 16/5/21.
//  Copyright © 2016年 YJ. All rights reserved.
//

#import "YJCollectionViewDataSource.h"
#import "YJCollectionViewDelegate.h"

@interface YJCollectionViewDataSource () {
    NSMutableArray<YJCollectionCellObject *> *_dataSource;
    NSMutableArray<NSMutableArray<YJCollectionCellObject *> *> *_dataSourceGrouped;
}

@property (nonatomic, strong) NSMutableSet<NSString *> *identifierSet; ///< 记录缓存过的identifier

@end

@implementation YJCollectionViewDataSource

#pragma mark - init
- (instancetype)initWithCollectionView:(UICollectionView *)collectionView {
    self = [super init];
    if (self) {
        _collectionView = collectionView;
        _delegate = [[YJCollectionViewDelegate alloc] initWithDataSource:self];
        self.identifierSet = [NSMutableSet set];
        // 默认设置代理
        self.collectionView.dataSource = self;
        self.collectionView.delegate = self.delegate;
    }
    return self;
}

#pragma mark - getter and setter
- (NSMutableArray<YJCollectionCellObject *> *)dataSource {
    if (!_dataSource) {
        _dataSource = [NSMutableArray array];
        [self.dataSourceGrouped addObject:_dataSource];
    }
    return _dataSource;
}

- (NSMutableArray<NSMutableArray<YJCollectionCellObject *> *> *)dataSourceGrouped {
    if (!_dataSourceGrouped) {
        _dataSourceGrouped = [NSMutableArray array];
    }
    return _dataSourceGrouped;
}

- (UICollectionViewFlowLayout *)flowLayout {
    return self.delegate.flowLayout;
}

#pragma mark - UICollectionViewDataSource
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return self.dataSourceGrouped.count;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.dataSourceGrouped[section].count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    YJCollectionCellObject *cellObject = self.dataSourceGrouped[indexPath.section][indexPath.item];
    cellObject.indexPath = indexPath;
    return  [self dequeueReusableCellWithCellObject:cellObject];
}

- (UICollectionViewCell *)dequeueReusableCellWithCellObject:(YJCollectionCellObject *)cellObject {
    NSString *identifier = @"identifier";
    switch (self.cacheCellStrategy) {
        case YJCollectionViewCacheCellDefault: // 根据相同的UITableViewCell类名缓存Cell
            identifier = cellObject.cellName;
            break;
        case YJCollectionViewCacheCellIndexPath: // 根据NSIndexPath对应的位置缓存Cell
            identifier = [NSString stringWithFormat:@"%ld-%ld", cellObject.indexPath.section, cellObject.indexPath.item];
            break;
        case YJCollectionViewCacheCellClassAndIndexPath: // 根据类名和NSIndexPath双重绑定缓存Cell
            identifier = [NSString stringWithFormat:@"%@(%ld-%ld)", cellObject.cellName, cellObject.indexPath.section, cellObject.indexPath.item];
            break;
    }
    // 判断是否缓存
    if (![self.identifierSet containsObject:identifier]) {
        switch (cellObject.createCell) {
                // 即使用[[UICollectionViewCell alloc] initWithFrame:CGRectZero]创建cell
            case YJCollectionCellCreateDefault: // 默认使用xib创建cell，推荐此方式
                [self.collectionView registerNib:[UINib nibWithNibName:cellObject.cellName bundle:nil] forCellWithReuseIdentifier:identifier];
                break;
            case YJCollectionCellCreateSoryboard: // 使用soryboard创建cell时，请使用类名作为标识符
                // Soryboard中设置UICollectionViewCell类名作为Identifier
                identifier = cellObject.cellName;
                break;
            case YJCollectionCellCreateClass: // 使用Class创建cell
                [self.collectionView registerClass:cellObject.cellClass forCellWithReuseIdentifier:identifier];
                break;
        }
        [self.identifierSet addObject:identifier];
    }
    // 读取缓存
    UICollectionViewCell *cell = [self.collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:cellObject.indexPath];
    // 刷新数据
    [cell reloadDataWithCellObject:cellObject delegate:self.delegate];
    return cell;
}

@end
