//
//  ViewController.m
//  YJCollectionView
//
//  Created by 阳君 on 16/5/16.
//  Copyright © 2016年 YJ. All rights reserved.
//

#import "ViewController.h"
#import "YJCollectionView.h"
#import "YJTestCollectionViewCell.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (nonatomic, strong) YJCollectionViewDataSource *dataSoutce; ///< 数据源管理

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.dataSoutce = [[YJCollectionViewDataSource alloc] initWithCollectionView:self.collectionView];
    // 测试数据
    for (int i = 0; i<100; i++) {
        YJTestCollectionCellModel *cellModel = [[YJTestCollectionCellModel alloc] init];
        cellModel.index = [NSString stringWithFormat:@"%d", i];
        [self.dataSoutce.dataSource addObject:[YJTestCollectionViewCell cellObjectWithCellModel:cellModel]];
    }
    // 设置相关属性
    self.dataSoutce.flowLayout.sectionInset = UIEdgeInsetsMake(5, 5, 5, 5);
    self.dataSoutce.flowLayout.minimumLineSpacing = 5;
    self.dataSoutce.flowLayout.minimumInteritemSpacing = 5;
    self.dataSoutce.delegate.lineItems = 3;          // 一行显示个数
    self.dataSoutce.delegate.itemHeightLayout = YES; // 是否自动适配高
}

@end
