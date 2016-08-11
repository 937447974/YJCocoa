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
    CGFloat _baseY;       ///< 基点,-1未初始化
    CGFloat _suspensionY; ///< 悬浮点
}

@property (nonatomic, weak, readonly) UITableView *tableView; ///< UITableView
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
    _contentOffsetY = contentOffsetY;
    _baseY = _baseY == -1 ? contentOffsetY : _baseY;
    CGFloat spaceY = _contentOffsetY - _baseY;
    self.widthFrame = self.tableView.widthFrame;
    self.topFrame = -_baseY;
    NSLog(@"%d", self.tableView.translatesAutoresizingMaskIntoConstraints);
    if (!self.indexPaths.count) {
        return;
    }
    
    NSInteger index = self.subviews.count ?  self.subviews.count-1 : 0;
    
    YJTableCellObject *cellObj = [self.indexPaths objectAtIndex:index];
    if (!cellObj.indexPath) {
        return;
    }
    
    if (self.suspensionCells.count < self.subviews.count || !self.suspensionCells.count) {
        UITableViewCell *cell = [self.tableViewDelegate.dataSource tableView:self.tableView cellForRowAtIndexPath:cellObj.indexPath];
        [self.suspensionCells addObject:cell];
    }
    if (!self.suspensionCells.count) {
        return;
    }
    
    CGRect rect = [self.tableView rectForRowAtIndexPath:cellObj.indexPath];    
    UITableViewCell *cell = [self.suspensionCells objectAtIndex:index];
    cell.topFrame = self.heightFrame;
    cell.sizeFrame = rect.size;
    if (self.subviews.count) { // 已有
        if (spaceY > rect.origin.y) { // 显示
            NSLog(@"持续显示");
        } else if (self.subviews.count) { // 隐藏
            NSLog(@"隐藏中");
            [self.subviews.lastObject removeFromSuperview];
            self.heightFrame = 0;
            [self.tableView reloadRowsAtIndexPaths:@[cellObj.indexPath] withRowAnimation:UITableViewRowAnimationNone];
        }
    } else { // 未有
        if (spaceY > rect.origin.y) { // 显示
            NSLog(@"持续显示");
            if (self.subviews.count) {
                return;
            }
            [self addSubview:cell];
            self.heightFrame = cell.heightFrame;
        }
    }
    
    
    
//    NSLog(@"移动距离：%f", _contentOffsetY-_baseY);
//    NSLog(@"_baseY：%f", _baseY);
//    NSIndexPath *ip = [NSIndexPath indexPathForRow:1 inSection:0];
////    static UITableViewCell *cell;
//    CGRect rect = [self.tableView rectForRowAtIndexPath:ip];
//    NSLog(@"%@", NSStringFromCGRect(rect));
////    if (cell == nil) {
////        cell = [self.tableViewDelegate.dataSource tableView:self.tableView cellForRowAtIndexPath:ip];
////        [self addSubview:cell];
////        cell.translatesAutoresizingMaskIntoConstraints = YES;
////        cell.sizeFrame = rect.size;
////        self.heightFrame = cell.heightFrame;
////    }
////    CGRect cr = cell.frame;
//    if (spaceY > rect.origin.y + rect.size.height) {
//        NSLog(@"持续显示");
//    } else if (spaceY > rect.origin.y) {
//        NSLog(@"显示动画中");
//    } else {
//        NSLog(@"隐藏中");
////        [cell removeFromSuperview];
////        [self.tableView reloadRowsAtIndexPaths:@[ip] withRowAnimation:UITableViewRowAnimationNone];
////        cell = nil;
//    }
}

@end
