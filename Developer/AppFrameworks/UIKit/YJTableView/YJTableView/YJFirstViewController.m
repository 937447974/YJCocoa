//
//  YJFirstViewController.m
//  YJUITableViewFactory
//
//  Created by 阳君 on 16/3/26.
//  Copyright © 2016年 YJCocoa. All rights reserved.
//

#import "YJFirstViewController.h"
#import "YJTestTableViewCell.h"
#import "YJTestTableViewCell2.h"

@interface YJFirstViewController () <YJUITableViewManagerDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

// 需要强引用
@property (nonatomic, strong) YJUITableViewManager *tableViewManager;

@end

@implementation YJFirstViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.tableViewManager = [[YJUITableViewManager alloc] initWithTableView:self.tableView];
    [self.tableViewManager addTableViewAOPDelegate:self];
    //    [self test1];
//    [self test2];
    [self test3];
}

#pragma mark - 测试数据
- (void)initTestData {
    CGFloat count = self.tableViewManager.dataSource.count;
    // 测试数据
    for (int i=count; i<count+10; i++) {
        // 封装模型
        YJTestTableCellModel *cellModel = [[YJTestTableCellModel alloc] init];
        cellModel.userName = [NSString stringWithFormat:@"阳君-%d", i];
        // 封装CellObject
        YJUITableCellObject *cellObject = [YJTestTableViewCell cellObjectWithCellModel:cellModel];
        // 填充数据源
        [self.tableViewManager.dataSource addObject:cellObject];
    }
    [self.tableView reloadData];
}

#pragma mark - 使用默认的YJUITableCellObject
- (void)test1 {
    [self initTestData];
}

#pragma mark - class
- (void)test2 {
    self.tableViewManager.delegateManager.cacheHeightStrategy = YJUITableViewCacheHeightIndexPath;
    for (int i = 0; i < 100; i++) {
        YJTestTableCellModel *cellModel = [[YJTestTableCellModel alloc] init];
        cellModel.userName = [NSString stringWithFormat:@"阳君-%d", i];
        [self.tableViewManager.dataSource addObject:[YJTestTableViewCell2 cellObjectWithCellModel:cellModel]];
    }
    [self.tableView reloadData];
}

#pragma mark - 协议监听dell
- (void)test3 {
    self.tableViewManager.delegate = self;
    self.tableViewManager.delegateManager.cacheHeightStrategy = YJUITableViewCacheHeightIndexPath;
    [self initTestData];
}

#pragma mark YJUITableViewCellProtocol
- (void)tableViewCell:(UITableViewCell *)cell sendWithCellObject:(YJUITableCellObject *)cellObject {
    NSLog(@"%@", NSStringFromSelector(_cmd));
}

#pragma mark YJUIScrollViewManagerDelegate
- (void)scrollViewManager:(YJUIScrollViewManager *)manager didVerticalScroll:(YJUIScrollViewScroll)scroll {
    NSLog(@"%@ -- %ld", NSStringFromSelector(_cmd), (long)scroll);
    if (scroll == YJUIScrollViewScrollEndBottom) { // 分页加载
        NSLog(@"%@分页加载", NSStringFromSelector(_cmd));
        [self initTestData];
    }
}

#pragma mark YJUITableViewManagerDelegate
- (void)tableViewManager:(YJUITableViewManager *)manager didSelectCellWithCellObject:(YJUITableCellObject *)cellObject {
    NSLog(@"%@", NSStringFromSelector(_cmd));
}

@end
