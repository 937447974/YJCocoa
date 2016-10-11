//
//  YJUITableViewCell.m
//  YJUITableViewFactory
//
//  HomePage:https://github.com/937447974/YJCocoa
//  YJ技术支持群:557445088
//
//  Created by 阳君 on 16/5/21.
//  Copyright © 2016年 YJCocoa. All rights reserved.
//

#import "YJUITableViewCell.h"
#import "YJUITableViewDelegate.h"
#import "YJNSFoundationOther.h"
#import "YJDispatch.h"

#pragma mark - UITableViewCell (YJUITableView)
@implementation UITableViewCell (YJUITableView)

#pragma mark - (+)
+ (YJUITableViewCellCreate)cellCreate {
    return YJUITableViewCellCreateDefault;
}

+ (id)cellObject {
    YJUITableCellObject *cellObject = [[YJUITableCellObject alloc] initWithTableViewCellClass:self.class];
    cellObject.createCell = [self cellCreate];
    return cellObject;
}

+ (id)cellObjectWithCellModel:(id<YJUITableCellModelProtocol>)cellModel {
    YJUITableCellObject *cellObject = [self cellObject];
    cellObject.cellModel = cellModel;
    return cellObject;
}

+ (CGFloat)tableView:(UITableView *)tableView heightForCellObject:(YJUITableCellObject *)cellObject {
    if (cellObject.createCell == YJUITableViewCellCreateClass) {
        NSLog(@"自动获取高度时，UITableViewCell子类%@请实现方法：%@", YJNSStringFromClass(self.class), NSStringFromSelector(_cmd));
        return tableView.rowHeight; // 默认高
    }
    // soryboard方式创建cell
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:YJNSStringFromClass(self.class)];
    if (cell) {
        return CGRectGetHeight(cell.frame);
    }
    // xib创建cell
    NSArray<UITableView *> *array = [[NSBundle mainBundle] loadNibNamed:YJNSStringFromClass(self.class) owner:nil options:nil];
    return CGRectGetHeight(array.firstObject.frame);
}

#pragma mark - (-)
- (void)reloadDataWithCellObject:(YJUITableCellObject *)cellObject tableViewDelegate:(YJUITableViewDelegate *)tableViewDelegate {
    [self reloadDataSyncWithCellObject:cellObject tableViewDelegate:tableViewDelegate];
    __weakSelf
    dispatch_async_main(^{// UI加速
        [weakSelf reloadDataAsyncWithCellObject:cellObject tableViewDelegate:tableViewDelegate];
    });
}

- (void)reloadDataSyncWithCellObject:(YJUITableCellObject *)cellObject tableViewDelegate:(YJUITableViewDelegate *)tableViewDelegate {
    NSLog(@"UITableViewCell子类%@请实现方法：%@", YJNSStringFromClass(self.class), NSStringFromSelector(_cmd));
}

- (void)reloadDataAsyncWithCellObject:(YJUITableCellObject *)cellObject tableViewDelegate:(YJUITableViewDelegate *)tableViewDelegate {
}

@end


#pragma mark - YJUITableViewCell
@implementation YJUITableViewCell

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

#pragma mark - YJUITableView
- (void)reloadDataSyncWithCellObject:(YJUITableCellObject *)cellObject tableViewDelegate:(YJUITableViewDelegate *)tableViewDelegate {
    _cellObject = cellObject;
    _tableViewDelegate = tableViewDelegate;
}

@end
