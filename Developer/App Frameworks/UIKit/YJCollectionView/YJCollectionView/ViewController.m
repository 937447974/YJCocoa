//
//  ViewController.m
//  YJCollectionView
//
//  Created by 阳君 on 16/5/16.
//  Copyright © 2016年 YJ. All rights reserved.
//

#import "ViewController.h"
#import "YJTCollectionView.h"
#import "YJTestCollectionViewCell.h"
#import "YJCSystem.h"
#import "YJTestCollectionReusableView.h"

@interface ViewController () <YJTCollectionViewCellProtocol>

@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (nonatomic, strong) YJTCollectionViewDataSource *dataSoutce; ///< 数据源管理

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.dataSoutce = [[YJTCollectionViewDataSource alloc] initWithCollectionView:self.collectionView];
    // 设置相关属性
    self.dataSoutce.flowLayout.sectionInset = UIEdgeInsetsMake(5, 5, 5, 5);
    self.dataSoutce.flowLayout.minimumLineSpacing = 5;
    self.dataSoutce.flowLayout.minimumInteritemSpacing = 5;
    self.dataSoutce.delegate.lineItems = 3;          // 一行显示个数
    self.dataSoutce.delegate.itemHeightLayout = YES; // 是否自动适配高
    self.dataSoutce.delegate.cellDelegate = self;
    // 测试数据
    for (int i = 0; i<20; i++) {
        YJTestCollectionCellModel *cellModel = [[YJTestCollectionCellModel alloc] init];
        cellModel.index = [NSString stringWithFormat:@"%d", i];
        [self.dataSoutce.dataSource addObject:[YJTestCollectionViewCell cellObjectWithCellModel:cellModel]];
    }
    // 头部、尾部
    YJTestCollectionReusableViewModel *hvm = [[YJTestCollectionReusableViewModel alloc] init];
    hvm.backgroundColor = [UIColor greenColor];
    [self.dataSoutce.headerDataSource addObject:[YJTestCollectionReusableView cellObjectWithCellModel:hvm]];
    YJTestCollectionReusableViewModel *fvm = [[YJTestCollectionReusableViewModel alloc] init];
    fvm.backgroundColor = [UIColor redColor];
    YJTCollectionCellObject *co = [YJTestCollectionReusableView cellObjectWithCellModel:fvm];
    co.createCell = YJTCollectionCellCreateClass;
    [self.dataSoutce.footerDataSource addObject:co];
}

#pragma mark - YJCollectionViewCellProtocol
- (void)collectionViewDidSelectCellWithCellObject:(YJTCollectionCellObject *)cellObject collectionViewCell:(nullable UICollectionViewCell *)cell {
    NSLog(@"%@", NSStringFromSelector(_cmd));
    [self.collectionView reloadData];
}

- (void)collectionViewLoadingPageData:(YJTCollectionCellObject *)cellObject willDisplayCell:(UICollectionViewCell *)cell {
    NSLog(@"%@", NSStringFromSelector(_cmd));
    NSLog(@"%@", self.dataSoutce.collectionHeaderView);
    NSLog(@"%@", self.dataSoutce.collectionFooterView);
    return;
    for (int i = 0; i<10; i++) {
        YJTestCollectionCellModel *cellModel = [[YJTestCollectionCellModel alloc] init];
        cellModel.index = [NSString stringWithFormat:@"%d", i];
        [self.dataSoutce.dataSource addObject:[YJTestCollectionViewCell cellObjectWithCellModel:cellModel]];
    }
    dispatch_async_main(^{
        [self.collectionView reloadData];
    });
}

- (void)collectionView:(UICollectionView *)collectionView scroll:(YJTCollectionViewScroll)scroll {
    NSLog(@"%lu", scroll);
}


@end
