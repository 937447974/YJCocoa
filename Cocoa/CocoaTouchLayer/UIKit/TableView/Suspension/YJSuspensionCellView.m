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
#import "YJAutoLayout.h"

#pragma mark - YJSuspensionCellView
@interface YJSuspensionCellView () {
    CGFloat _suspensionY; ///< 悬浮点
}

@property (nonatomic, strong) NSIndexPath *indexPath; ///< 当前cell所处位置
@property (nonatomic) CGFloat index; ///< 当前显示下标
@property (nonatomic, weak, readonly) UITableView *tableView; ///< UITableView
@property (nonatomic, strong) NSMutableArray<YJTableCellObject *> *indexPaths;    ///< 悬浮的Cell对象
@property (nonatomic, strong) NSMutableArray<UITableViewCell *> *suspensionCells; ///< 悬浮的Cell队列

@end

@implementation YJSuspensionCellView

#pragma mark - 刷新
- (void)reloadData {
    [self removeConstraints:self.constraints];
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

#pragma mark frame 显示
- (void)showWithFrame:(YJTableCellObject *)cellObj {
//    self.widthFrame = self.tableView.widthFrame;
//    //    self.topFrame = -_baseY;
//    NSLog(@"%d", self.tableView.translatesAutoresizingMaskIntoConstraints);
//    
//    CGRect rect = [self.tableView rectForRowAtIndexPath:cellObj.indexPath];
//    UITableViewCell *cell = [self.suspensionCells objectAtIndex:index];
//    cell.topFrame = self.heightFrame;
//    cell.sizeFrame = rect.size;
//    if (self.subviews.count) { // 已有
//        if (_contentOffsetY > rect.origin.y) { // 显示
//            NSLog(@"持续显示");
//        } else if (self.subviews.count) { // 隐藏
//            NSLog(@"隐藏中");
//            [self.subviews.lastObject removeFromSuperview];
//            self.heightFrame = 0;
//            [self.tableView reloadRowsAtIndexPaths:@[cellObj.indexPath] withRowAnimation:UITableViewRowAnimationNone];
//        }
//    } else { // 未有
//        if (_contentOffsetY > rect.origin.y) { // 显示
//            NSLog(@"持续显示");
//            if (self.subviews.count) {
//                return;
//            }
//            [self addSubview:cell];
//            self.heightFrame = cell.heightFrame;
//        }
//    }
}

#pragma mark 约束显示
- (void)showWithAuto:(YJTableCellObject *)cellObj {
    CGRect rect = [self.tableView rectForRowAtIndexPath:cellObj.indexPath];
    UITableViewCell *cell = [self.suspensionCells objectAtIndex:self.index];
    // 添加
    if (self.index == self.subviews.count) {
        [self addSubview:cell];
        cell.leadingSpaceToSuper(0).trailingSpaceToSuper(0).heightLayout.equalToConstant(rect.size.height);
        if (self.index) {
            UIView *lastView = [self.subviews objectAtIndex:self.index-1];
            cell.topLayout.equalTo(lastView.bottomLayout);
        } else {
            cell.topSpaceToSuper(0);
        }
    }
    // 显示
    if (_contentOffsetY > rect.origin.y) { // 显示
        self.heightLayout.equalToConstant(rect.size.height);
        [cell setHidden:NO];
        NSLog(@"持续显示");
    } else { // 隐藏
        NSLog(@"隐藏中");
        self.heightLayout.equalToConstant(0);
        [self.tableView reloadRowsAtIndexPaths:@[cellObj.indexPath] withRowAnimation:UITableViewRowAnimationNone];
    }
}

#pragma mark 根据YJTableCellObject生成UITableViewCell
- (UITableViewCell *)dequeueReusableCellWithCellObject:(YJTableCellObject *)cellObject {
    // 生成cell
    UITableViewCell *cell;
    if (cell == nil) {
        switch (cellObject.createCell) {
            case YJTableViewCellCreateDefault:
                cell = [[UINib nibWithNibName:cellObject.cellName bundle:nil] instantiateWithOwner:nil options:nil].firstObject;
                break;
            case YJTableViewCellCreateSoryboard:
                NSAssert(NO, @"悬浮cel不支持YJTableViewCellCreateSoryboard创建cell");
                break;
            case YJTableViewCellCreateClass:
                cell = [[cellObject.cellClass alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
                break;
        }
    }
    // 刷新数据
    [cell reloadDataWithCellObject:cellObject tableViewDelegate:self.tableViewDelegate];
    return cell;
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
    if (!self.indexPaths.count) {
        return;
    }
    
    YJTableCellObject *cellObj = [self.indexPaths objectAtIndex:self.index];
    if (!cellObj.indexPath) {
        return;
    }
    
    if (self.suspensionCells.count <= self.subviews.count) {
        [self.suspensionCells addObject:[self dequeueReusableCellWithCellObject:cellObj]];
    }
    if (!self.suspensionCells.count) {
        return;
    }
    
    if (self.translatesAutoresizingMaskIntoConstraints) {
        [self showWithFrame:cellObj];
    } else {
        [self showWithAuto:cellObj];
    }
}

@end
