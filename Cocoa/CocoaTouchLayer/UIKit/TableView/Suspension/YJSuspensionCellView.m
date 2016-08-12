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

@property (nonatomic) CGFloat index; ///< 当前显示下标
@property (nonatomic, weak, readonly) UITableView *tableView; ///< UITableView
@property (nonatomic, strong) NSMutableArray<YJTableCellObject *> *indexPaths;    ///< 悬浮的Cell对象
@property (nonatomic, strong) NSMutableArray<UITableViewCell *> *suspensionCells; ///< 悬浮的Cell队列

@end

@implementation YJSuspensionCellView

#pragma mark - 刷新数据
- (void)reloadData {
    if (self.translatesAutoresizingMaskIntoConstraints) {
        self.heightFrame = 0;
    } else {
        [self removeConstraints:self.constraints];
        //        [self scrollTopAutolayout];
    }
    
    for (UIView *view in self.subviews) {
        [view removeFromSuperview];
    }
    [self.indexPaths removeAllObjects];
    [self.suspensionCells removeAllObjects];
    for (NSArray<YJTableCellObject *> *array in self.tableViewDelegate.dataSource.dataSourceGrouped) {
        for (YJTableCellObject *co in array) {
            if (co.suspension) {
                [self.indexPaths addObject:co];
            }
        }
    }
}

#pragma mark - 根据YJTableCellObject生成UITableViewCell
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

#pragma mark - 滑动显示
#pragma mark 上滑
- (void)scrollTop {
    if (self.indexPaths.count != self.subviews.count) {
        // 是否已显示
        YJTableCellObject *cellObj = [self.indexPaths objectAtIndex:self.subviews.count];
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
        [self scrollTopFrame];
    } else {
        [self scrollTopAutolayout];
    }
}

#pragma mark 上滑frame布局
- (void)scrollTopFrame {
    
}

#pragma mark 上滑自动布局
- (void)scrollTopAutolayout {
    // 添加
    if (self.suspensionCells.count != self.subviews.count) {
        UITableViewCell *cell = [self.suspensionCells objectAtIndex:self.subviews.count];
        [self addSubview:cell];
        YJTableCellObject *cellObj = [self.indexPaths objectAtIndex:self.subviews.count-1];
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
    YJTableCellObject *cellObj = [self.indexPaths objectAtIndex:self.index];
    CGRect rect = [self.tableView rectForRowAtIndexPath:cellObj.indexPath];
    if (self.index) {
        if (_contentOffsetY + heightConstraint.constant > rect.origin.y + rect.size.height) {
            self.heightLayout.equalToConstant(rect.size.height);
            self.index ++;
        } else if (_contentOffsetY + heightConstraint.constant > rect.origin.y) {
            CGFloat newConstant = _contentOffsetY + heightConstraint.constant - rect.origin.y + rect.size.height;
            NSLayoutConstraint *topItemConstraint = self.subviews.firstObject.topLayout.costraintTo(self.topLayout);
            topItemConstraint.constants(topItemConstraint.constant + newConstant - heightConstraint.constant);
            heightConstraint.constants(newConstant);
        }
    } else {
        self.subviews.firstObject.topSpaceToSuper(0);
        if (_contentOffsetY > rect.origin.y) {
            heightConstraint.constants(rect.size.height);
            self.index ++;
        }
    }
}

#pragma mark 下滑
- (void)scrollBottom {
    if (!self.suspensionCells.count) {
        return;
    }
    if (self.translatesAutoresizingMaskIntoConstraints) {
        [self scrollBottomFrame];
    } else {
        [self scrollBottomAutolayout];
    }
}

#pragma mark 下滑frame布局
- (void)scrollBottomFrame {
    
}

#pragma mark 下滑自动布局
- (void)scrollBottomAutolayout {
    if (self.index < 0 || self.index >= self.subviews.count) {
        return;
    }
    NSLayoutConstraint *heightConstraint = self.heightLayout.constraint();
    if (!heightConstraint.constant || !self.index) {
        return;
    }
    YJTableCellObject *cellObj = [self.indexPaths objectAtIndex:self.index-1];
    CGRect rect = [self.tableView rectForRowAtIndexPath:cellObj.indexPath];
    if (self.index == 1) {
        if (_contentOffsetY < rect.origin.y) {
            heightConstraint.constants(0);
            [self.tableView reloadRowsAtIndexPaths:@[cellObj.indexPath] withRowAnimation:UITableViewRowAnimationNone];
            self.index = 0;
        }
    } else {
        if (_contentOffsetY + heightConstraint.constant > rect.origin.y + rect.size.height) {
            self.heightLayout.equalToConstant(rect.size.height);
            [self.tableView reloadRowsAtIndexPaths:@[cellObj.indexPath] withRowAnimation:UITableViewRowAnimationNone];
            self.index --;
        } else if (_contentOffsetY + heightConstraint.constant < rect.origin.y) {
            
            CGFloat newConstant = _contentOffsetY + heightConstraint.constant - rect.origin.y + rect.size.height;
            NSLayoutConstraint *topItemConstraint = self.subviews.firstObject.topLayout.costraintTo(self.topLayout);
            topItemConstraint.constants(topItemConstraint.constant + newConstant - heightConstraint.constant);
            heightConstraint.constants(newConstant);
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
    if (!self.indexPaths.count) {
        return;
    }
    BOOL top = contentOffsetY > _contentOffsetY;
    _contentOffsetY = contentOffsetY;
    top ? [self scrollTop] : [self scrollBottom];
}

@end
