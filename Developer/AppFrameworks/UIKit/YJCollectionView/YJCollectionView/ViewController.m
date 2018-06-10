//
//  ViewController.m
//  YJCollectionView
//
//  Created by 阳君 on 16/5/16.
//  Copyright © 2016年 YJ. All rights reserved.
//

#import "ViewController.h"
#import "YJTestCollectionViewCell.h"
#import "YJTest2CollectionViewCell.h"
#import "YJDispatch.h"
#import "YJTestCollectionReusableView.h"
#import "YJUICollectionView.h"

@interface ViewController () <YJUICollectionViewManagerDelegate, UICollectionViewDelegate>

@property (weak, nonatomic) IBOutlet YJUICollectionView *collectionView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // 设置相关属性
    self.collectionView.manager.delegateFlowLayoutManager.flowLayout.sectionInset = UIEdgeInsetsMake(5, 5, 5, 5);
    self.collectionView.manager.delegateFlowLayoutManager.flowLayout.minimumLineSpacing = 5;
    self.collectionView.manager.delegateFlowLayoutManager.flowLayout.minimumInteritemSpacing = 5;
    self.collectionView.manager.delegateFlowLayoutManager.lineItems = 3;          // 一行显示个数
    self.collectionView.manager.delegateFlowLayoutManager.itemHeightLayout = YES; // 是否自动适配高
    self.collectionView.alwaysBounceVertical = YES;
    [self testDefault];
//    [self testClass];
}

- (void)testDefault {
    self.collectionView.manager.delegate = self;
    // AOP代理
    [self.collectionView.manager addCollectionViewAOPDelegate:self];
    // 测试数据
    for (int i = 0; i < 2; i++) {
        YJTestCollectionCellModel *cellModel = [[YJTestCollectionCellModel alloc] init];
        cellModel.index = [NSString stringWithFormat:@"%d", i];
        [self.collectionView.dataSourcePlain addObject:[YJTestCollectionViewCell cellObjectWithCellModel:cellModel]];
    }
    // 头部、尾部
    YJTestCollectionReusableViewModel *hvm = [[YJTestCollectionReusableViewModel alloc] init];
    hvm.backgroundColor = [UIColor greenColor];
    [self.collectionView.dataSourceHeader addObject:[YJTestCollectionReusableView cellObjectWithCellModel:hvm]];
    YJTestCollectionReusableViewModel *fvm = [[YJTestCollectionReusableViewModel alloc] init];
    fvm.backgroundColor = [UIColor redColor];
    YJUICollectionCellObject *co = [YJTestCollectionReusableView cellObjectWithCellModel:fvm];
    co.createCell = YJUICollectionCellCreateClass;
    [self.collectionView.dataSourceFooter addObject:co];
}

- (void)testClass {
    // 测试数据
    for (int i = 0; i < 1000; i++) {
        YJTestCollectionCellModel *cellModel = [[YJTestCollectionCellModel alloc] init];
        cellModel.index = [NSString stringWithFormat:@"%d", i];
        [self.collectionView.dataSourcePlain addObject:[YJTest2CollectionViewCell cellObjectWithCellModel:cellModel]];
    }
    [self.collectionView reloadData];
}

#pragma mark - YJCollectionViewCellProtocol
- (void)collectionCell:(UICollectionViewCell *)cell sendWithCellObject:(YJUICollectionCellObject *)cellObject {
    NSLog(@"%@", NSStringFromSelector(_cmd));
}

#pragma mark - YJUIScrollViewManagerDelegate
- (void)scrollViewManager:(YJUIScrollViewManager *)manager didVerticalScroll:(YJUIScrollViewScroll)scroll {
    NSLog(@"%@ -- %ld", NSStringFromSelector(_cmd), (long)scroll);
    if (scroll == YJUIScrollViewScrollEndBottom) { // 分页加载
//        [self testClass];
        NSLog(@"%@分页加载", NSStringFromSelector(_cmd));
    }
}

#pragma mark - YJUICollectionViewManagerDelegate
- (void)collectionViewManager:(YJUICollectionViewManager *)manager didSelectCellWithCellObject:(YJUICollectionCellObject *)cellObject {
    NSLog(@"%@", NSStringFromSelector(_cmd));
}

#pragma mark - UICollectionViewDelegate
- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"%@--%@", NSStringFromSelector(_cmd), indexPath);
    return YES;
}

@end
