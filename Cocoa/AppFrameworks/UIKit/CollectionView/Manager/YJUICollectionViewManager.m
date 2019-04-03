//
//  YJUICollectionViewManager.m
//  YJCollectionView
//
//  HomePage:https://github.com/937447974/YJCocoa
//  YJ技术支持群:557445088
//
//  Created by 阳君 on 2016/10/18.
//  Copyright © 2016年 YJCocoa. All rights reserved.
//

#import "YJUICollectionViewManager.h"
#import "YJNSAspectOrientProgramming.h"
#import "YJNSLog.h"

@interface YJUICollectionViewManager (){
    YJNSAspectOrientProgramming *_aopDelegate; ///< 切面代理
}
@end

@implementation YJUICollectionViewManager

- (instancetype)initWithCollectionView:(UICollectionView *)collectionView {
    self = [super init];
    if (self) {
        self.dataSourceGrouped = [NSMutableArray array];
        [self.dataSourceGrouped addObject:[NSMutableArray array]];
        _collectionView = collectionView;
        _dataSourceManager = [[YJUICollectionViewDataSourceManager alloc] initWithManager:self];
        _delegateFlowLayoutManager = [[YJUICollectionViewDelegateFlowLayoutManager alloc] initWithManager:self];
        _scrollViewManager = [[YJUIScrollViewManager alloc] initWithScrollView:collectionView];
        [self addCollectionViewAOPDelegate:_scrollViewManager];
    }
    return self;
}

- (void)addCollectionViewAOPDelegate:(id)delegate {
    if (!_aopDelegate) {
        _aopDelegate = [[YJNSAspectOrientProgramming alloc] init];
        [_aopDelegate addTarget:_dataSourceManager];
        [_aopDelegate addTarget:_delegateFlowLayoutManager];
    }
    [_aopDelegate addTarget:delegate];
    self.collectionView.dataSource = (id<UICollectionViewDataSource>)_aopDelegate;
    self.collectionView.delegate = (id<UICollectionViewDelegate>)_aopDelegate;
}

#pragma mark - getter and setter
- (void)setDataSourcePlain:(NSMutableArray<YJUICollectionCellObject *> *)dataSourcePlain {
    if (!dataSourcePlain) {
        YJLogError(@"[YJCocoa] 数组为空; selector:%@", NSStringFromSelector(_cmd));
        dataSourcePlain = [NSMutableArray array];
    }
    if (self.dataSourceGrouped.count) {
        [self.dataSourceGrouped replaceObjectAtIndex:0 withObject:dataSourcePlain];
    } else {
        [self.dataSourceGrouped addObject:dataSourcePlain];
    }
}
- (NSMutableArray<YJUICollectionCellObject *> *)dataSourcePlain {
    return self.dataSourceGrouped.firstObject;
}

- (void)setDelegate:(id<YJUICollectionViewManagerDelegate>)delegate {
    _delegate = delegate;
    self.scrollViewManager.delegate = delegate;
}

@end
