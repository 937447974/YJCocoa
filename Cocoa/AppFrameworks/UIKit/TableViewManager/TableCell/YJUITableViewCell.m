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
#import "YJUITableViewManager.h"
#import "YJDispatch.h"
#import "YJNSFoundationOther.h"

#pragma mark - UITableViewCell (YJUITableView)
@implementation UITableViewCell (YJUITableView)

#pragma mark - (+)
+ (YJUITableViewCellCreate)cellCreate {
    [self doesNotRecognizeSelector:_cmd];
    return YJUITableViewCellCreateClass;
}

+ (YJUITableCellObject *)cellObject {
    YJUITableCellObject *cellObject = [[YJUITableCellObject alloc] initWithTableViewCellClass:self.class];
    cellObject.createCell = self.cellCreate;
    return cellObject;
}

+ (YJUITableCellObject *)cellObjectWithCellModel:(id<YJUITableCellModelProtocol>)cellModel {
    YJUITableCellObject *cellObject = [self cellObject];
    cellObject.cellModel = cellModel;
    return cellObject;
}

+ (CGFloat)tableViewManager:(YJUITableViewManager *)tableViewManager heightForCellObject:(YJUITableCellObject *)cellObject {
    if (cellObject.createCell == YJUITableViewCellCreateClass) {
        return tableViewManager.tableView.rowHeight; // 默认高
    }
    // soryboard方式创建cell
    UITableViewCell *cell = [tableViewManager.tableView dequeueReusableCellWithIdentifier:cellObject.cellName];
    if (cell) {
        return CGRectGetHeight(cell.frame);
    }
    // xib创建cell
    NSArray<UITableView *> *array = [[NSBundle mainBundle] loadNibNamed:cellObject.cellName owner:nil options:nil];
    return CGRectGetHeight(array.firstObject.frame);
}

#pragma mark - (-)
- (void)reloadDataWithCellObject:(YJUITableCellObject *)cellObject tableViewManager:(YJUITableViewManager *)tableViewManager; {
    [self reloadDataSyncWithCellObject:cellObject tableViewManager:tableViewManager];
    __weakSelf
    dispatch_async_main(^{// UI加速
        [weakSelf reloadDataAsyncWithCellObject:cellObject tableViewManager:tableViewManager];
    });
}

- (void)reloadDataSyncWithCellObject:(YJUITableCellObject *)cellObject tableViewManager:(YJUITableViewManager *)tableViewManager {
    NSLog(@"UITableViewCell子类%@请实现方法：%@", cellObject.cellName, NSStringFromSelector(_cmd));
}

- (void)reloadDataAsyncWithCellObject:(YJUITableCellObject *)cellObject tableViewManager:(YJUITableViewManager *)tableViewManager {
}

- (void)reloadDataCacheWithCellObject:(YJUITableCellObject *)cellObject tableViewManager:(YJUITableViewManager *)tableViewManager {
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

#pragma mark - getter & setter
- (NSString *)reuseIdentifier {
    NSString *reuseIdentifier = [super reuseIdentifier];
    if (reuseIdentifier) return reuseIdentifier;
    return YJNSStringFromClass(self.class);
}

#pragma mark - YJUITableView
+ (YJUITableViewCellCreate)cellCreate {
    if ([YJNSStringFromClass([YJUITableViewCell class]) isEqualToString:YJNSStringFromClass(self.class)]) {
        return YJUITableViewCellCreateClass;
    }
    return [super cellCreate];
}

- (void)reloadDataSyncWithCellObject:(YJUITableCellObject *)cellObject tableViewManager:(YJUITableViewManager *)tableViewManager {
    _cellObject = cellObject;
    _tableViewManager = tableViewManager;
}

@end
