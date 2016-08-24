//
//  YJTTableViewCell.m
//  YJTTableViewFactory
//
//  HomePage:https://github.com/937447974/YJCocoa
//  YJ技术支持群:557445088
//
//  Created by 阳君 on 16/5/21.
//  Copyright © 2016年 YJCocoa. All rights reserved.
//

#import "YJTTableViewCell.h"
#import "YJTTableViewDelegate.h"
#import "YJSFoundationOther.h"
#import "YJCSystem.h"

#pragma mark - UITableViewCell (YJTTableView)
@implementation UITableViewCell (YJTTableView)

#pragma mark - (+)
+ (YJTTableViewCellCreate)cellCreate {
    return YJTTableViewCellCreateDefault;
}

+ (id)cellObject {
    YJTTableCellObject *cellObject = [[YJTTableCellObject alloc] initWithTableViewCellClass:self.class];
    cellObject.createCell = [self cellCreate];
    return cellObject;
}

+ (id)cellObjectWithCellModel:(id<YJTTableCellModelProtocol>)cellModel {
    YJTTableCellObject *cellObject = [self cellObject];
    cellObject.cellModel = cellModel;
    return cellObject;
}

+ (CGFloat)tableView:(UITableView *)tableView heightForCellObject:(YJTTableCellObject *)cellObject {
    if (cellObject.createCell == YJTTableViewCellCreateClass) {
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
- (void)reloadDataWithCellObject:(YJTTableCellObject *)cellObject tableViewDelegate:(YJTTableViewDelegate *)tableViewDelegate {
    [self reloadDataSyncWithCellObject:cellObject tableViewDelegate:tableViewDelegate];
    __weakSelf
    dispatch_async_main(^{// UI加速
        [weakSelf reloadDataAsyncWithCellObject:cellObject tableViewDelegate:tableViewDelegate];
    });
}

- (void)reloadDataSyncWithCellObject:(YJTTableCellObject *)cellObject tableViewDelegate:(YJTTableViewDelegate *)tableViewDelegate {
    NSLog(@"UITableViewCell子类%@请实现方法：%@", YJStringFromClass(self.class), NSStringFromSelector(_cmd));
}

- (void)reloadDataAsyncWithCellObject:(YJTTableCellObject *)cellObject tableViewDelegate:(YJTTableViewDelegate *)tableViewDelegate {
}

@end


#pragma mark - YJTTableViewCell
@implementation YJTTableViewCell

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

#pragma mark - YJTTableView
- (void)reloadDataSyncWithCellObject:(YJTTableCellObject *)cellObject tableViewDelegate:(YJTTableViewDelegate *)tableViewDelegate {
    _cellObject = cellObject;
    _tableViewDelegate = tableViewDelegate;
}

@end
