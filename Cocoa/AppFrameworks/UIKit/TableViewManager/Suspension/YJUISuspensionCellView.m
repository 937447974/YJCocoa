//
//  YJUISuspensionCellView.m
//  YJUITableView
//
//  HomePage:https://github.com/937447974/YJCocoa
//  YJ技术支持群:557445088
//
//  Created by 阳君 on 16/8/23.
//  Copyright © 2016年 YJCocoa. All rights reserved.
//

#import "YJUISuspensionCellView.h"
#import "YJUITableViewManager.h"
#import "UIView+YJUIViewGeometry.h"
#import "YJAutoLayout.h"

@interface YJUISuspensionCellView () {
    CGFloat _showCellHeight;  ///< 当前显示Cell高
}

@property (nonatomic) BOOL scrollAnimate; ///< 悬浮cell动画滑动中
@property (nonatomic) NSInteger index;    ///< 当前显示下标, 1代表第一个cell固定显示
@property (nonatomic, strong) NSMutableArray<YJUITableCellObject *> *indexPaths;    ///< 悬浮的Cell对象
@property (nonatomic, strong) NSMutableArray<UITableViewCell *> *suspensionCells; ///< 悬浮的Cell队列

@end

@implementation YJUISuspensionCellView

#pragma mark - 刷新数据
- (void)reloadData {
    _showCellHeight = 0;
    self.index = 0;
    self.scrollAnimate = NO;
    if (self.translatesAutoresizingMaskIntoConstraints) {
        self.heightFrame = 0;
    } else {
        NSLog(@"不支持IOS10以上的系统，请使用frame布局");
        [self removeConstraints:self.constraints];
        self.heightLayout.equalToConstant(0);
    }
    for (UIView *view in self.subviews) {
        [view removeFromSuperview];
    }
    [self.indexPaths removeAllObjects];
    [self.suspensionCells removeAllObjects];
    for (NSArray<YJUITableCellObject *> *array in self.manager.dataSourceGrouped) {
        for (YJUITableCellObject *co in array) {
            if (co.suspension) {
                [self.indexPaths addObject:co];
            }
        }
    }
}

#pragma mark - 根据YJUITableCellObject生成UITableViewCell
- (UITableViewCell *)dequeueReusableCellWithCellObject:(YJUITableCellObject *)cellObject {
    // 生成cell
    UITableViewCell *cell;
    if (cell == nil) {
        switch (cellObject.createCell) {
            case YJUITableViewCellCreateDefault:
                cell = [[UINib nibWithNibName:cellObject.cellName bundle:nil] instantiateWithOwner:nil options:nil].firstObject;
                break;
            case YJUITableViewCellCreateSoryboard:
                NSAssert(NO, @"悬浮cel不支持YJUITableViewCellCreateSoryboard创建cell");
                break;
            case YJUITableViewCellCreateClass:
                cell = [[cellObject.cellClass alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
                break;
        }
    }
    // 刷新数据
    [cell reloadDataWithCellObject:cellObject tableViewManager:self.manager];
    return cell;
}

#pragma mark - tableView滑动显示
#pragma mark tableView滑到顶
- (void)scrollToTop {
    if (!self.suspensionCells.count) {
        return;
    }
    if (self.translatesAutoresizingMaskIntoConstraints) {
        [self scrollToTopFrame];
    } else {
        [self scrollToTopAutolayout];
    }
}

#pragma mark tableView滑到顶frame布局
- (void)scrollToTopFrame {
    NSInteger showIndex = self.scrollAnimate ? self.index : self.index-1;
    if (showIndex < 0 || showIndex >= self.subviews.count) {
        return;
    }
    YJUITableCellObject *cellObj = [self.indexPaths objectAtIndex:showIndex];
    CGRect rect = [self.tableView rectForRowAtIndexPath:cellObj.indexPath];
    if (_contentOffsetY > rect.origin.y) {
        return;
    }
    if (showIndex) {
        if (self.scrollAnimate && self.heightFrame >= rect.size.height + _showCellHeight) {
            self.scrollAnimate = NO;
            [self.manager.dataSourceManager reloadRowsAtIndexPaths:@[cellObj]];
            self.heightFrame = _showCellHeight;
            CGFloat topItemY = 0;
            for (int i = 0; i < self.index-1; i++) {
                topItemY += [self.suspensionCells objectAtIndex:i].heightFrame;
            }
            self.topBounds = topItemY;
        } else {
            if (!self.scrollAnimate) {
                self.index --;
                _showCellHeight = [self.suspensionCells objectAtIndex:self.index-1].heightFrame;
            }
            self.scrollAnimate = YES;
            CGFloat newHeight = rect.origin.y + rect.size.height - self.contentOffsetY;
            self.topBounds -= newHeight - self.heightFrame;
            self.heightFrame = newHeight;
        }
    } else {
        self.scrollAnimate = NO;
        [self.manager.dataSourceManager reloadRowsAtIndexPaths:@[cellObj]];
        _showCellHeight = 0;
        self.heightFrame = 0;
        self.index = 0;
    }
}

#pragma mark tableView滑到顶自动布局
- (void)scrollToTopAutolayout {
    NSInteger showIndex = self.scrollAnimate ? self.index : self.index-1;
    if (showIndex < 0 || showIndex >= self.subviews.count) {
        return;
    }
    NSLayoutConstraint *heightConstraint = self.heightLayout.constraint();
    if (!heightConstraint.constant) {
        return;
    }
    YJUITableCellObject *cellObj = [self.indexPaths objectAtIndex:showIndex];
    CGRect rect = [self.tableView rectForRowAtIndexPath:cellObj.indexPath];
    if (_contentOffsetY > rect.origin.y) {
        return;
    }
    if (showIndex) {
        if (self.scrollAnimate && heightConstraint.constant >= rect.size.height + _showCellHeight) {
            self.scrollAnimate = NO;
            [self.manager.dataSourceManager reloadRowsAtIndexPaths:@[cellObj]];
            heightConstraint.constant = _showCellHeight;
            CGFloat topItemY = 0;
            for (int i = 0; i < self.index-1; i++) {
                topItemY += [self.suspensionCells objectAtIndex:i].heightFrame;
            }
            self.topBounds = topItemY;
        } else {
            if (!self.scrollAnimate) {
                self.index --;
                _showCellHeight = [self.suspensionCells objectAtIndex:self.index-1].heightFrame;
            }
            self.scrollAnimate = YES;
            CGFloat newHeight = rect.origin.y + rect.size.height - self.contentOffsetY;
            self.topBounds -= newHeight - heightConstraint.constant;
            heightConstraint.constant = newHeight;
        }
    } else {
        self.scrollAnimate = NO;
        [self.manager.dataSourceManager reloadRowsAtIndexPaths:@[cellObj]];
        heightConstraint.constants(0);
        _showCellHeight = 0;
        self.index = 0;
    }
}

#pragma mark tableView滑到底
- (void)scrollToBottom {
    if (self.indexPaths.count != self.subviews.count) { // 是否已初始化
        YJUITableCellObject *cellObj = [self.indexPaths objectAtIndex:self.subviews.count];
        if (cellObj.indexPath) {
            if (self.suspensionCells.count <= self.subviews.count) {
                [self.suspensionCells addObject:[self dequeueReusableCellWithCellObject:cellObj]];
            }
        }
    }
    if (!self.suspensionCells.count) {
        return;
    }
    if (self.translatesAutoresizingMaskIntoConstraints) {
        [self scrollToBottomFrame];
    } else {
        [self scrollToBottomAutolayout];
    }
}

#pragma mark tableView滑到底frame布局
- (void)scrollToBottomFrame {
    // 添加
    if (self.suspensionCells.count != self.subviews.count) {
        UITableViewCell *cell = [self.suspensionCells objectAtIndex:self.subviews.count];
        [self addSubview:cell];
        YJUITableCellObject *cellObj = [self.indexPaths objectAtIndex:self.subviews.count-1];
        cell.frame = [self.tableView rectForRowAtIndexPath:cellObj.indexPath];
        if (self.subviews.count >= 2) {
            cell.topFrame = self.subviews[self.subviews.count-2].bottomFrame;
        } else {
            cell.topFrame = 0;
        }
    }
    // 显示
    if (self.index < 0 || self.index >= self.subviews.count) {
        return;
    }
    YJUITableCellObject *cellObj = [self.indexPaths objectAtIndex:self.index];
    CGRect rect = [self.tableView rectForRowAtIndexPath:cellObj.indexPath];
    self.scrollAnimate = NO;
    if (self.index) {
        if (_contentOffsetY > rect.origin.y) {
            _showCellHeight = rect.size.height;
            self.heightFrame = _showCellHeight;
            CGFloat topItemY = 0;
            for (int i = 0; i < self.index; i++) {
                topItemY += [self.suspensionCells objectAtIndex:i].heightFrame;
            }
            self.topBounds = topItemY;
            self.index ++;
        } else if (_contentOffsetY + _showCellHeight > rect.origin.y) {
            self.scrollAnimate = YES;
            CGFloat newHeight = rect.origin.y + rect.size.height - _contentOffsetY;
            if (self.heightFrame < newHeight) {
                [[self.suspensionCells objectAtIndex:self.index] reloadDataWithCellObject:cellObj tableViewManager:self.manager];
                self.topBounds += self.heightFrame + rect.size.height - newHeight;
            } else {
                self.topBounds += self.heightFrame - newHeight;
            }
            self.heightFrame = newHeight;
        }
    } else {
        self.topBounds = 0;
        if (_contentOffsetY > rect.origin.y) {
            [self.suspensionCells.firstObject reloadDataWithCellObject:cellObj tableViewManager:self.manager];
            _showCellHeight = rect.size.height;
            self.heightFrame = _showCellHeight;
            self.index ++;
        }
    }
}

#pragma mark tableView滑到底自动布局
- (void)scrollToBottomAutolayout {
    // 添加
    if (self.suspensionCells.count != self.subviews.count) {
        UITableViewCell *cell = [self.suspensionCells objectAtIndex:self.subviews.count];
        [self addSubview:cell];
        YJUITableCellObject *cellObj = [self.indexPaths objectAtIndex:self.subviews.count-1];
        CGRect rect = [self.tableView rectForRowAtIndexPath:cellObj.indexPath];
        cell.leadingSpaceToSuper(0);
        cell.heightLayout.equalToConstant(rect.size.height);
        cell.widthLayout.equalToConstant(rect.size.width);
        if (self.subviews.count >= 2) {
            cell.topLayout.equalTo(self.subviews[self.subviews.count-2].bottomLayout);
        } else {
            cell.topSpaceToSuper(0);
        }
    }
    // 显示
    if (self.index < 0 || self.index >= self.subviews.count) {
        return;
    }
    NSLayoutConstraint *heightConstraint = self.heightLayout.constraint();
    if (!heightConstraint) {
        heightConstraint = self.heightLayout.equalToConstant(0);
    }
    YJUITableCellObject *cellObj = [self.indexPaths objectAtIndex:self.index];
    CGRect rect = [self.tableView rectForRowAtIndexPath:cellObj.indexPath];
    self.scrollAnimate = NO;
    if (self.index) {
        if (_contentOffsetY > rect.origin.y) {
             _showCellHeight = rect.size.height;
            self.heightLayout.equalToConstant(_showCellHeight);           
            CGFloat topItemY = 0;
            for (int i = 0; i < self.index; i++) {
                topItemY += [self.suspensionCells objectAtIndex:i].heightFrame;
            }
            self.topBounds = topItemY;
            self.index ++;
        } else if (_contentOffsetY + _showCellHeight > rect.origin.y) {
            self.scrollAnimate = YES;
            CGFloat newHeight = rect.origin.y + rect.size.height - _contentOffsetY;
            if (heightConstraint.constant < newHeight) {
                [[self.suspensionCells objectAtIndex:self.index] reloadDataWithCellObject:cellObj tableViewManager:self.manager];
                self.topBounds += heightConstraint.constant + rect.size.height - newHeight;
            } else {
                self.topBounds += heightConstraint.constant - newHeight;
            }
            heightConstraint.constants(newHeight);
        }
    } else {
        self.topBounds = 0;
        if (_contentOffsetY > rect.origin.y) {
            [self.suspensionCells.firstObject reloadDataWithCellObject:cellObj tableViewManager:self.manager];
            heightConstraint.constants(rect.size.height);
            _showCellHeight = rect.size.height;
            self.index ++;
        }
    }
}

#pragma mark - setter and getter
- (UITableView *)tableView {
    return self.manager.tableView;
}

- (NSMutableArray<YJUITableCellObject *> *)indexPaths {
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
    if (!self.indexPaths.count) {
        return;
    }
    BOOL goBottom = contentOffsetY > _contentOffsetY;
    _contentOffsetY = contentOffsetY;
    goBottom ? [self scrollToBottom] : [self scrollToTop];
}

@end

