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
    //    [self test1];
    [self test2];
//    [self test3];
    //    [self test4];
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
        YJUITableCellObject *co = [YJTestTableViewCell2 cellObjectWithCellModel:cellModel];
        if (i <= 9) {
            co.reuseIdentifier = [NSString stringWithFormat:@"%@-%d", co.reuseIdentifier, i];
        }
        [self.tableViewManager.dataSource addObject:co];
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

#pragma mark YJUITableViewManagerDelegate
- (void)tableViewManager:(YJUITableViewManager *)manager didSelectCellWithCellObject:(YJUITableCellObject *)cellObject {
    NSLog(@"%@", NSStringFromSelector(_cmd));
}

- (void)tableViewManager:(YJUITableViewManager *)manager loadingPageDataWillDisplayCell:(UITableViewCell *)cell {
    NSLog(@"%@", NSStringFromSelector(_cmd));
    NSLog(@"分页加载数据");
    [self initTestData];
}

- (void)tableViewManager:(YJUITableViewManager *)manager scroll:(YJUITableViewScroll)scroll {
    NSLog(@"%@--%lu", NSStringFromSelector(_cmd), scroll);
}

#pragma mark - 悬浮测试
- (void)test4 {
    UIView *tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, 30)];
    tableHeaderView.backgroundColor = [UIColor blueColor];
    self.tableView.tableHeaderView = tableHeaderView;
    self.tableViewManager.delegateManager.cacheHeightStrategy = YJUITableViewCacheHeightIndexPath;
    // 测试数据
    for (int i=0; i<150; i++) {
        // 封装模型
        YJTestTableCellModel *cellModel = [[YJTestTableCellModel alloc] init];
        cellModel.userName = [NSString stringWithFormat:@"阳君-%d", i];
        // 封装CellObject
        YJUITableCellObject *cellObject = [YJTestTableViewCell cellObjectWithCellModel:cellModel];
        cellObject.suspension = i%10 == 0;
        // 填充数据源
        [self.tableViewManager.dataSource addObject:cellObject];
    }
//    [self.tableViewManager.tableViewDelegate.suspensionCellView reloadData]; // 悬浮cell开始工作 IOS10+不支持约束悬浮
}

@end
