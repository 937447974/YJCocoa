//
//  ViewController.m
//  YJCollectionView
//
//  Created by 阳君 on 16/5/16.
//  Copyright © 2016年 YJ. All rights reserved.
//

#import "ViewController.h"
#import <YJcocoa/YJCocoa-Swift.h>
#import "YJCollectionView-Swift.h"

@interface ViewController () <UICollectionViewDelegate>

@property (weak, nonatomic) IBOutlet YJUICollectionView *collectionView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // 设置相关属性
    self.collectionView.manager.flowLayout.sectionInset = UIEdgeInsetsMake(5, 5, 5, 5);
    self.collectionView.manager.flowLayout.minimumLineSpacing = 5;
    self.collectionView.manager.flowLayout.minimumInteritemSpacing = 5;
    self.collectionView.alwaysBounceVertical = YES;
    [self testDefault];
}

- (void)testDefault {
    // 测试数据
    NSMutableArray *dataSourceCell = NSMutableArray.array;
    for (int i = 0; i < 30; i++) {
        YJTestCollectionCellModel *cellModel = [[YJTestCollectionCellModel alloc] init];
        cellModel.index = [NSString stringWithFormat:@"%d", i];
        YJUICollectionCellObject *co = [YJTestCollectionViewCell cellObjectWithCellModel:cellModel];
        co.didSelectBlock = ^(YJUICollectionViewManager *cvm, YJUICollectionCellObject *co) {
            NSLog(cellModel.index, nil);
        };
        [dataSourceCell addObject:co];
    }
    self.collectionView.dataSourceCell = @[dataSourceCell];
    // 头部、尾部
    YJTestCollectionReusableViewModel *hvm = [[YJTestCollectionReusableViewModel alloc] init];
    hvm.backgroundColor = [UIColor greenColor];
    self.collectionView.dataSourceHeader = @[[YJTestCollectionReusableView cellObjectWithCellModel:hvm]];
    YJTestCollectionReusableViewModel *fvm = [[YJTestCollectionReusableViewModel alloc] init];
    fvm.backgroundColor = [UIColor redColor];
    self.collectionView.dataSourceFooter = @[[YJTestCollectionReusableView cellObjectWithCellModel:fvm]];
}

@end
