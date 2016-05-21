//
//  YJTableViewCell.m
//  YJTableViewFactory
//
//  HomePage:https://github.com/937447974/YJCocoa
//  YJ技术支持群:557445088
//
//  Created by admin on 16/5/21.
//  Copyright © 2016年 YJFactory. All rights reserved.
//

#import "YJTableViewCell.h"
#import "YJTableViewDelegate.h"
#import "YJFoundation.h"
#import "YJSystem.h"

#pragma mark - UITableViewCell (YJTableView)
@implementation UITableViewCell (YJTableView)

#pragma mark - (+)
+ (id)cellObject {
    return [[YJTableCellObject alloc] initWithTableViewCellClass:self.class];
}

+ (id)cellObjectWithCellModel:(id<YJTableCellModelProtocol>)cellModel {
    YJTableCellObject *cellObject = [[YJTableCellObject alloc] initWithTableViewCellClass:self.class];
    cellObject.cellModel = cellModel;
    return cellObject;
}

+ (CGFloat)tableView:(UITableView *)tableView heightForCellObject:(YJTableCellObject *)cellObject {
    if (cellObject.createCell == YJTableViewCellCreateClass) {
        NSLog(@"自动获取高度时，UITableViewCell子类%@请实现方法：%@", YJStringFromClass(self.class), NSStringFromSelector(_cmd));
        return tableView.rowHeight; // 默认高
    }
    // soryboard方式创建cell
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:YJStringFromClass(self.class)];
    if (cell) {
        return CGRectGetHeight(cell.frame);
    }
    // xib创建cell
    NSArray<UITableView *> *array = [[NSBundle mainBundle] loadNibNamed:YJStringFromClass(self.class) owner:nil options:nil];
    return CGRectGetHeight(array.firstObject.frame);
}

#pragma mark - (-)
- (void)reloadDataWithCellObject:(YJTableCellObject *)cellObject tableViewDelegate:(YJTableViewDelegate *)tableViewDelegate {
    [self reloadDataSyncWithCellObject:cellObject tableViewDelegate:tableViewDelegate];
    __weak UITableViewCell *weakSelf = self;
    dispatch_async_UI(^{// UI加速
        [weakSelf reloadDataAsyncWithCellObject:cellObject tableViewDelegate:tableViewDelegate];
        [weakSelf reloadCellWithCellObject:cellObject tableViewDelegate:tableViewDelegate];
    });
}

- (void)reloadDataSyncWithCellObject:(YJTableCellObject *)cellObject tableViewDelegate:(YJTableViewDelegate *)tableViewDelegate {
    NSLog(@"UITableViewCell子类%@请实现方法：%@", YJStringFromClass(self.class), NSStringFromSelector(_cmd));
}

- (void)reloadDataAsyncWithCellObject:(YJTableCellObject *)cellObject tableViewDelegate:(YJTableViewDelegate *)tableViewDelegate {
    NSLog(@"UITableViewCell子类%@请实现方法：%@", YJStringFromClass(self.class), NSStringFromSelector(_cmd));
}

- (void)reloadCellWithCellObject:(YJTableCellObject *)cellObject tableViewDelegate:(YJTableViewDelegate *)tableViewDelegate {
    NSLog(@"UITableViewCell子类%@请实现方法：%@", YJStringFromClass(self.class), NSStringFromSelector(_cmd));
}

@end


#pragma mark - YJTableViewCell
@implementation YJTableViewCell

#pragma mark - init
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // 80%以上的业务都不会需要点击效果，故屏蔽
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return self;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}

#pragma mark - YJTableView
- (void)reloadDataSyncWithCellObject:(YJTableCellObject *)cellObject tableViewDelegate:(YJTableViewDelegate *)tableViewDelegate {
    [super reloadDataSyncWithCellObject:cellObject tableViewDelegate:tableViewDelegate];
}

- (void)reloadDataAsyncWithCellObject:(YJTableCellObject *)cellObject tableViewDelegate:(YJTableViewDelegate *)tableViewDelegate {
    _cellObject = cellObject;
    _tableViewDelegate = tableViewDelegate;
}

- (void)reloadCellWithCellObject:(YJTableCellObject *)cellObject tableViewDelegate:(YJTableViewDelegate *)tableViewDelegate {
    _cellObject = cellObject;
    _tableViewDelegate = tableViewDelegate;
}


@end
