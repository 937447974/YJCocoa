//
//  YJFirstViewController.m
//  YJUITableViewFactory
//
//  Created by 阳君 on 16/3/26.
//  Copyright © 2016年 YJCocoa. All rights reserved.
//

#import "YJFirstViewController.h"
#import "YJTableView-Swift.h"
#import <YJCocoa/YJCocoa-Swift.h>

@interface YJFirstViewController ()

@property (nonatomic, strong) YJUITableView *tableView;


@end

@implementation YJFirstViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.tableView = [[YJUITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    self.tableView.delegate = self.tableView.manamger;
    self.tableView.dataSource = self.tableView.manamger;
    self.tableView.manamger.cacheHeight = YJUITableViewCacheHeightIndexPath;
    [self.view addSubview:self.tableView];
    
    [self initTestData];
}

#pragma mark - 测试数据
- (void)initTestData {
    NSMutableArray *array = NSMutableArray.array;
    // 测试数据
    for (int i = 0; i < 10; i++) {
        // 封装模型
        YJTestTVCellModel *cellModel = [[YJTestTVCellModel alloc] init];
        cellModel.userName = [NSString stringWithFormat:@"阳君-%d", i];
        // 封装CellObject
        YJUITableCellObject *cellObject = [YJTestTVCell  cellObjectWithCellModel:cellModel];
        cellObject.didSelectBlock = ^(YJUITableViewManager *m, YJUITableCellObject *co) {
            NSLog(@"%d", i);
        };
        // 填充数据源
        [array addObject:cellObject];
    }
    self.tableView.dataSourceCellFirst = array;
    [self.tableView reloadData];
}

@end
