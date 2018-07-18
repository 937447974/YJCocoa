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
#import "YJUITableView.h"
#import "UIView+YJUIViewGeometry.h"
#import "YJUITableViewHeaderView.h"

@interface YJFirstViewController () <YJUITableViewManagerDelegate>

@property (nonatomic, strong) YJUITableView *tableView;


@end

@implementation YJFirstViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.tableView = [[YJUITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    [self.view addSubview:self.tableView];
    
    //    [self test1];
//    [self test2];
//    [self test3];
    [self test4];
}

#pragma mark - 测试数据
- (void)initTestData {
    CGFloat count = self.tableView.dataSourcePlain.count;
    // 测试数据
    for (int i=count; i<count+10; i++) {
        // 封装模型
        YJTestTableCellModel *cellModel = [[YJTestTableCellModel alloc] init];
        cellModel.userName = [NSString stringWithFormat:@"阳君-%d", i];
        // 封装CellObject
        YJUITableCellObject *cellObject = [YJTestTableViewCell cellObjectWithCellModel:cellModel];
        // 填充数据源
        [self.tableView.dataSourcePlain addObject:cellObject];
    }
    [self.tableView reloadData];
}

#pragma mark - 使用默认的YJUITableCellObject
- (void)test1 {
    [self initTestData];
}

#pragma mark - class
- (void)test2 {
    self.tableView.manager.delegateManager.cacheHeightStrategy = YJUITableViewCacheHeightIndexPath;
    for (int i = 0; i < 100; i++) {
        YJTestTableCellModel *cellModel = [[YJTestTableCellModel alloc] init];
        cellModel.userName = [NSString stringWithFormat:@"阳君-%d", i];
        [self.tableView.dataSourcePlain addObject:[YJTestTableViewCell2 cellObjectWithCellModel:cellModel]];
    }
    [self.tableView reloadData];
}

#pragma mark - 协议监听cell
- (void)test3 {
    [self.tableView.manager addTableViewAOPDelegate:self];
    self.tableView.manager.delegate = self;
    self.tableView.manager.delegateManager.cacheHeightStrategy = YJUITableViewCacheHeightIndexPath;
    [self initTestData];
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

#pragma mark -
- (void)test4 {
    self.tableView.sectionHeaderHeight = 20;
    [self.tableView.dataSourceGrouped removeAllObjects];
    for (int i = 0; i < 3; i++) {
        [self.tableView.dataSourceHeader addObject:YJUITableViewHeaderView.cellObject];
        NSMutableArray *array = [NSMutableArray arrayWithCapacity:20];
        for (int j=0; j<10; j++) {
            // 封装模型
            YJTestTableCellModel *cellModel = [[YJTestTableCellModel alloc] init];
            cellModel.userName = [NSString stringWithFormat:@"阳君-%d-%d", i, j];
            YJUITableCellObject *co = [YJTestTableViewCell cellObjectWithCellModel:cellModel];
            // 填充数据源
            [array addObject:co];
        }
        [self.tableView.dataSourceGrouped addObject:array];
    }    
}

@end
