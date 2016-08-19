//
//  YJSecondViewController.m
//  YJTableViewFactory
//
//  Created by 阳君 on 16/3/26.
//  Copyright © 2016年 YJCocoa. All rights reserved.
//

#import "YJSecondViewController.h"
#import "YJTestTableViewCell.h"

@interface YJSecondViewController () <UITableViewDelegate>

@property (nonatomic, strong) UITableView *tableView;

// 需要强引用
@property (nonatomic, strong) YJTableViewDataSource *dataSourceGrouped;

@end

@implementation YJSecondViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
    [self.view addSubview:self.tableView];
    self.dataSourceGrouped = [[YJTableViewDataSource alloc] initWithTableView:self.tableView];
    self.dataSourceGrouped.tableViewDelegate.cacheHeightStrategy = YJTableViewCacheHeightIndexPath;
//    self.tableView.delegate = self;
    // 测试数据
    for (int i=0; i<3; i++) {
        NSMutableArray *array = [NSMutableArray arrayWithCapacity:20];
        for (int j=0; j<30; j++) {
            // 封装模型
            YJTestTableCellModel *cellModel = [[YJTestTableCellModel alloc] init];
            cellModel.userName = [NSString stringWithFormat:@"阳君-%d", j];
            YJTableCellObject *co = [YJTestTableViewCell cellObjectWithCellModel:cellModel];
            co.suspension = i%10 == 0;
            // 填充数据源
            [array addObject:co];
        }
        [self.dataSourceGrouped.dataSourceGrouped addObject:array];
    }
    [self.dataSourceGrouped.tableViewDelegate.suspensionCellView reloadData];
}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [self.dataSourceGrouped.tableViewDelegate tableView:tableView heightForRowAtIndexPath:indexPath];    
}

@end
