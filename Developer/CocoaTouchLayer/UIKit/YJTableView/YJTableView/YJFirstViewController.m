//
//  YJFirstViewController.m
//  YJTableViewFactory
//
//  Created by 阳君 on 16/3/26.
//  Copyright © 2016年 YJCocoa. All rights reserved.
//

#import "YJFirstViewController.h"
#import "YJTestTableViewCell.h"

@interface YJFirstViewController () <YJTableViewCellProtocol>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

// 需要强引用
@property (nonatomic, strong) YJTableViewDataSource *dataSourcePlain;

@end

@implementation YJFirstViewController

- (void)viewDidLoad {
    [super viewDidLoad];
     self.automaticallyAdjustsScrollViewInsets=NO;
    UIView *tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, 30)];
    tableHeaderView.backgroundColor = [UIColor redColor];
    self.tableView.tableHeaderView = tableHeaderView;
    self.dataSourcePlain = [[YJTableViewDataSource alloc] initWithTableView:self.tableView];
//    [self test1];
//    [self test2];
//    [self test3];
//    [self test4];
    [self test5];
}

#pragma mark - 测试数据
- (void)initTestData {
    // 测试数据
    for (int i=0; i<10; i++) {
        // 封装模型
        YJTestTableCellModel *cellModel = [[YJTestTableCellModel alloc] init];
        cellModel.userName = [NSString stringWithFormat:@"阳君-%d", i];
        // 封装CellObject
        YJTableCellObject *cellObject = [YJTestTableViewCell cellObjectWithCellModel:cellModel];
        // 填充数据源
        [self.dataSourcePlain.dataSource addObject:cellObject];
    }
    [self.tableView reloadData];
}

#pragma mark - 使用默认的YJTableCellObject
- (void)test1 {
    [self initTestData];
}

#pragma mark - 使用自定义的YJTableViewCellObject
- (void)test2 {
    // 测试数据
    for (int i=0; i<20; i++) {
        // 封装模型
        YJTestTableCellModel *cellModel = [[YJTestTableCellModel alloc] init];
        cellModel.userName = [NSString stringWithFormat:@"阳君-%d", i];
        // 封装CellObject
        YJTestTableCellObject *cellObject = [[YJTestTableCellObject alloc] init];
        cellObject.cellModel = cellModel;
        // 填充数据源
        [self.dataSourcePlain.dataSource addObject:cellObject];
    }
}

#pragma mark - 通过协议监听点击dell
- (void)test3 {
    self.dataSourcePlain.tableViewDelegate.cellDelegate = self;
    [self initTestData];
}

#pragma mark YJTableViewDelegateProtocol
- (void)tableViewDidSelectCellWithCellObject:(YJTableCellObject *)cellObject tableViewCell:(UITableViewCell *)cell {
    NSLog(@"%@", NSStringFromSelector(_cmd));
}

- (void)tableViewLoadingPageData:(YJTableCellObject *)cellObject willDisplayCell:(UITableViewCell *)cell {
    NSLog(@"%@", NSStringFromSelector(_cmd));
    [self initTestData];
}

- (void)tableView:(UITableView *)tableView scroll:(YJTableViewScroll)scroll {
    NSLog(@"%lu", scroll);
}

#pragma mark - 通过block监听点击dell
- (void)test4 {
    self.dataSourcePlain.tableViewDelegate.cellBlock = ^(YJTableCellObject *cellObject, UITableViewCell *tableViewCell) {
        NSLog(@"%@", cellObject.indexPath);
    };
    [self initTestData];
}

#pragma mark - 悬浮测试
- (void)test5 {
    // 测试数据
    for (int i=0; i<150; i++) {
        // 封装模型
        YJTestTableCellModel *cellModel = [[YJTestTableCellModel alloc] init];
        cellModel.userName = [NSString stringWithFormat:@"阳君-%d", i];
        // 封装CellObject
        YJTableCellObject *cellObject = [YJTestTableViewCell cellObjectWithCellModel:cellModel];
        cellObject.suspension = i%10 == 0;
        // 填充数据源
        [self.dataSourcePlain.dataSource addObject:cellObject];
    }
}

@end
