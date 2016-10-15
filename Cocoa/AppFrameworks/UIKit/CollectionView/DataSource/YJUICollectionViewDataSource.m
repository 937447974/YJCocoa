//
//  YJUICollectionViewDataSource.m
//  YJUICollectionView
//
//  HomePage:https://github.com/937447974/YJCocoa
//  YJ技术支持群:557445088
//
//  Created by 阳君 on 16/5/21.
//  Copyright © 2016年 YJCocoa. All rights reserved.
//

#import "YJUICollectionViewDataSource.h"
#import "YJUICollectionViewDelegate.h"
#import "YJNSAspectOrientProgramming.h"

@interface YJUICollectionViewDataSource () {
    YJNSAspectOrientProgramming *_collectionViewAOPDelegate; ///< aop代理
}

@property (nonatomic, strong) NSMutableSet<NSString *> *identifierSet; ///< 记录缓存过的identifier

@end

@implementation YJUICollectionViewDataSource

#pragma mark - main
- (instancetype)initWithCollectionView:(UICollectionView *)collectionView {
    self = [super init];
    if (self) {
        self.identifierSet = [NSMutableSet set];
        self.headerDataSource = [NSMutableArray array];
        self.footerDataSource = [NSMutableArray array];
        _dataSourceGrouped = [NSMutableArray array];
        _dataSource = [NSMutableArray array];
        [self.dataSourceGrouped addObject:_dataSource];
        //
        _collectionView = collectionView;
        _delegate = [[YJUICollectionViewDelegate alloc] initWithDataSource:self];
        // 默认设置代理
        self.collectionView.dataSource = self;
        self.collectionView.delegate = self.delegate;
    }
    return self;
}

#pragma mark 快速刷新已加载cell
- (void)reloadItemsAtCellObjects:(NSArray<YJUICollectionCellObject *> *)cellObjects; {
    UICollectionViewCell *cell;
    for (YJUICollectionCellObject *cellObject in cellObjects) {
        cell = [self.collectionView cellForItemAtIndexPath:cellObject.indexPath];
        [cell reloadDataWithCellObject:cellObject delegate:self.delegate];
    }
}

#pragma mark 获取cellObject对应的缓存key
- (NSString *)getKeyFromCellObject:(YJUICollectionCellObject *)cellObject {
    switch (self.cacheCellStrategy) {
        case YJUICollectionViewCacheCellDefault: // 根据相同的UITableViewCell类名缓存Cell
            return cellObject.cellName;
            break;
        case YJUICollectionViewCacheCellIndexPath: // 根据NSIndexPath对应的位置缓存Cell
            return [NSString stringWithFormat:@"%ld-%ld", cellObject.indexPath.section, cellObject.indexPath.item];
            break;
        case YJUICollectionViewCacheCellClassAndIndexPath: // 根据类名和NSIndexPath双重绑定缓存Cell
            return [NSString stringWithFormat:@"%@(%ld-%ld)", cellObject.cellName, cellObject.indexPath.section, cellObject.indexPath.item];
            break;
    }
}

- (void)addCollectionViewAOPDelegate:(id)delegate {
    if (!_collectionViewAOPDelegate) {
        _collectionViewAOPDelegate = [[YJNSAspectOrientProgramming alloc] init];
        [_collectionViewAOPDelegate addTarget:self];
        [_collectionViewAOPDelegate addTarget:self.delegate];
    }
    [_collectionViewAOPDelegate addTarget:delegate];
    self.collectionView.dataSource = (id<UICollectionViewDataSource>)_collectionViewAOPDelegate;
    self.collectionView.delegate = (id<UICollectionViewDelegate>)_collectionViewAOPDelegate;
}

#pragma mark - getter and setter
- (UICollectionViewFlowLayout *)flowLayout {
    return self.delegate.flowLayout;
}

- (void)setCollectionHeaderView:(UICollectionReusableView *)collectionHeaderView {
    _collectionHeaderView = collectionHeaderView;
    self.flowLayout.headerReferenceSize = collectionHeaderView.frame.size;
}

- (void)setCollectionFooterView:(UICollectionReusableView *)collectionFooterView {
    _collectionFooterView = collectionFooterView;
    self.flowLayout.footerReferenceSize = collectionFooterView.frame.size;
}

- (void)setDataSource:(NSMutableArray<YJUICollectionCellObject *> *)dataSource {
    _dataSource = dataSource;
    [self.dataSourceGrouped removeAllObjects];
    [self.dataSourceGrouped addObject:dataSource];
}

- (YJNSAspectOrientProgramming *)collectionViewAOPDelegate {
    if (!_collectionViewAOPDelegate) {
        _collectionViewAOPDelegate = [[YJNSAspectOrientProgramming alloc] init];
        [_collectionViewAOPDelegate addTarget:self];
        [_collectionViewAOPDelegate addTarget:self.delegate];
        // 默认设置代理
        self.collectionView.dataSource = (id<UICollectionViewDataSource>)_collectionViewAOPDelegate;
        self.collectionView.delegate = (id<UICollectionViewDelegate>)_collectionViewAOPDelegate;
    }
    return _collectionViewAOPDelegate;
}

#pragma mark - UICollectionViewDataSource
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return self.dataSourceGrouped.count;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.dataSourceGrouped[section].count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    YJUICollectionCellObject *cellObject = self.dataSourceGrouped[indexPath.section][indexPath.item];
    cellObject.indexPath = indexPath;
    UICollectionViewCell *cell = [self dequeueReusableCellWithCellObject:cellObject];
    NSInteger section = self.dataSourceGrouped.count - 1;
    NSInteger item = self.dataSourceGrouped[section].count - 1;
    if (indexPath.section == section && indexPath.item == item  && [self.delegate.cellDelegate respondsToSelector:@selector(collectionViewLoadingPageData:willDisplayCell:)]) { // 加载数据
        [self.delegate.cellDelegate collectionViewLoadingPageData:cellObject willDisplayCell:cell];
    }
    return  cell;
}

- (UICollectionViewCell *)dequeueReusableCellWithCellObject:(YJUICollectionCellObject *)cellObject {
    NSString *identifier = [self getKeyFromCellObject:cellObject];
    // 判断是否缓存
    if (![self.identifierSet containsObject:identifier]) {
        switch (cellObject.createCell) {
            case YJUICollectionCellCreateDefault: // 默认使用xib创建cell，推荐此方式
                [self.collectionView registerNib:[UINib nibWithNibName:cellObject.cellName bundle:nil] forCellWithReuseIdentifier:identifier];
                break;
            case YJUICollectionCellCreateSoryboard: // 使用soryboard创建cell时，请使用类名作为标识符
                // Soryboard中设置UICollectionViewCell类名作为Identifier
                identifier = cellObject.cellName;
                break;
            case YJUICollectionCellCreateClass: // 使用Class创建cell，即使用[[UICollectionViewCell alloc] initWithFrame:CGRectZero]创建cell
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

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    YJUICollectionCellObject *cellObject;
    if ([UICollectionElementKindSectionHeader isEqualToString:kind]) {
         cellObject = self.headerDataSource[indexPath.section];
    } else {
        cellObject = self.footerDataSource[indexPath.section];
    }
    cellObject.indexPath = indexPath;
    // 判断是否缓存
    NSString *identifier = [NSString stringWithFormat:@"%@-%@", kind, [self getKeyFromCellObject:cellObject]];
    if (![self.identifierSet containsObject:identifier]) {
        switch (cellObject.createCell) {
            case YJUICollectionCellCreateDefault: // 默认使用xib创建cell，推荐此方式
                [self.collectionView registerNib:[UINib nibWithNibName:cellObject.cellName bundle:nil]  forSupplementaryViewOfKind:kind withReuseIdentifier:identifier];
                break;
            case YJUICollectionCellCreateSoryboard: // 使用soryboard创建cell时，请使用类名作为标识符
                // Soryboard中设置UICollectionViewCell类名作为Identifier
                identifier = cellObject.cellName;
                break;
            case YJUICollectionCellCreateClass: // 使用Class创建cell，即使用[[UICollectionReusableView alloc] initWithFrame:CGRectZero]创建cell
                [self.collectionView registerClass:cellObject.cellClass forSupplementaryViewOfKind:kind withReuseIdentifier:identifier];
                break;
        }
        [self.identifierSet addObject:identifier];
    }
    // 读取缓存
    UICollectionReusableView *rv = [self.collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:identifier forIndexPath:indexPath];
    // 刷新数据
    [rv reloadDataWithCellObject:cellObject delegate:self.delegate];
    // 指向
    if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
        _collectionHeaderView = rv;
    } else {
        _collectionFooterView = rv;
    }
    return rv;
}

@end
