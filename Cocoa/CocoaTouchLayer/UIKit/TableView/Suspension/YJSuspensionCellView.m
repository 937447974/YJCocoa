//
//  YJSuspensionCellView.m
//  YJTableViewFactory
//
//  HomePage:https://github.com/937447974/YJCocoa
//  YJ技术支持群:557445088
//
//  Created by 阳君 on 16/5/11.
//  Copyright © 2016年 YJCocoa. All rights reserved.
//

#import "YJSuspensionCellView.h"
#import "YJTableViewDelegate.h"
#import "YJTableViewDataSource.h"
#import "UIView+YJViewGeometry.h"

#pragma mark - YJSuspensionCellView
@interface YJSuspensionCellView () {
    CGFloat _baseY; ///< 基点,-1未初始化
}

@property (nonatomic, weak) UITableView *tableView; ///< UITableView
@property (nonatomic, strong) NSMutableArray<YJTableCellObject *> *indexPaths;    ///< 悬浮的Cell对象
@property (nonatomic, strong) NSMutableArray<UITableViewCell *> *suspensionCells; ///< 悬浮的Cell队列

@end

@implementation YJSuspensionCellView

#pragma mark - init
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        _baseY = -1;
    }
    return self;
}

#pragma mark - 刷新
- (void)reloadData {
    for (UIView *view in self.subviews) {
        [view removeFromSuperview];
    }
    [self.indexPaths removeAllObjects];
    [self.suspensionCells removeAllObjects];
    self.heightFrame = 0;
    for (NSArray<YJTableCellObject *> *array in self.tableViewDelegate.dataSource.dataSourceGrouped) {
        for (YJTableCellObject *co in array) {
            if (co.suspension) {
                [self.indexPaths addObject:co];
            }
        }
    }    
}

#pragma mark - setter and getter
- (UITableView *)tableView {
    return self.tableViewDelegate.dataSource.tableView;
}

- (NSMutableArray<YJTableCellObject *> *)indexPaths {
    if (!_indexPaths) {
        _indexPaths = [NSMutableArray array];
    }
    return _indexPaths;
}

- (NSMutableArray<UITableViewCell *> *)suspensionCells {
    if (!_suspensionCells) {
        _suspensionCells = [NSMutableArray array];
    }
    return _suspensionCells;
}

- (void)setContentOffsetY:(CGFloat)contentOffsetY {
    _baseY = _baseY == -1 ? contentOffsetY : _baseY;
    _contentOffsetY = contentOffsetY;
    self.widthFrame = self.tableViewDelegate.dataSource.tableView.widthFrame;
    
//    NSLog(@"%f", _contentOffsetY);
//    NSLog(@"%f", _baseY);
    /*
    
    static NSString *c ;
    if (!c) {
        c = @"11";
        self.dataSource.tableView
    }
    NSIndexPath *ip = [NSIndexPath indexPathForRow:1 inSection:0];
    static UITableViewCell *cell;
    CGRect rect = [self.dataSource.tableView rectForRowAtIndexPath:ip];
    if (cell == nil) {
        cell = [self.dataSource tableView:self.dataSource.tableView cellForRowAtIndexPath:ip];
        [self.dataSource.tableView.superview addSubview:cell];
        [cell setNeedsUpdateConstraints];
    }
    CGRect cr = cell.frame;
    cr.size = rect.size;
    CGPoint contentOffset = scrollView.contentOffset;
    NSLog(@"%@", NSStringFromCGPoint(contentOffset));
    NSLog(@"%@", NSStringFromCGRect([self.dataSource.tableView rectForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]]));
    if (contentOffset.y > rect.origin.y + rect.size.height) {
        cr.origin.y = self.dataSource.tableView.frame.origin.y;
        cell.frame = cr;
        NSLog(@"持续显示");
    } else if (contentOffset.y > rect.origin.y) {
        NSLog(@"显示动画中");
        cr.origin.y = rect.origin.y - contentOffset.y+self.dataSource.tableView.frame.origin.y;
        cell.frame = cr;
    } else {
        [cell removeFromSuperview];
        cell = nil;
    }
    //    NSLog(@"%@",NSStringFromCGRect(rect));
    //    NSLog(@"%@",[self.dataSource tableView:self.dataSource.tableView cellForRowAtIndexPath:ip]);
    */
}

@end
