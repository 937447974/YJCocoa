//
//  YJUITableViewManager.h
//  YJTableView
//
//  HomePage:https://github.com/937447974/YJCocoa
//  YJ技术支持群:557445088
//
//  Created by 阳君 on 2016/10/17.
//  Copyright © 2016年 YJCocoa. All rights reserved.
//

#import "YJUITableViewDataSourceManager.h"
#import "YJUITableViewDelegateManager.h"
#import "YJUIScrollViewManager.h"

NS_ASSUME_NONNULL_BEGIN

/** YJUITableViewManager的代理*/
@protocol YJUITableViewManagerDelegate <YJUITableViewCellProtocol, YJUIScrollViewManagerDelegate>

@optional

/**
 *  @abstract 用户点击整个Cell
 *
 *  @param cellObject    用户点击的cell数据
 *  @param tableViewCell 用户点击的Cell
 */
- (void)tableViewManager:(YJUITableViewManager *)manager didSelectCellWithCellObject:(YJUITableCellObject *)cellObject;

@end


/** UITableView管理器*/
@interface YJUITableViewManager : NSObject

@property (nonatomic, strong) NSMutableArray<YJUITableCellObject *> *dataSource; ///< 数据源UITableViewStylePlain
@property (nonatomic, strong, readonly) NSMutableArray<NSMutableArray<YJUITableCellObject *> *> *dataSourceGrouped; ///< 数据源UITableViewStyleGrouped

@property (nonatomic, weak, nullable) id<YJUITableViewManagerDelegate> delegate; ///< YJUITableViewManagerDelegate

@property (nonatomic, weak, readonly) UITableView *tableView; ///< UITableView

@property (nonatomic, strong, readonly) YJUITableViewDataSourceManager *dataSourceManager; ///< YJUITableViewDataSourceManager
@property (nonatomic, strong, readonly) YJUITableViewDelegateManager *delegateManager; ///< YJUITableViewDelegateManager
@property (nonatomic, strong, readonly) YJUIScrollViewManager *scrollViewManager; ///< YJUIScrollViewManager

/**
 *  @abstract 初始化YJUITableViewManager
 *  @discusstion 会自动填充设置tableView.dataSource=self.dataSourceManager; tableView.delegate=self.delegateManager;
 *
 *  @param tableView UITableView
 *
 *  @return YJUITableViewManager
 */
- (instancetype)initWithTableView:(UITableView *)tableView;

/**
 *  @abstract 添加UITableView的AOP代理
 *  @discusstion VC想实现UITableViewDataSource和UITableViewDelegate时，又不想替换框架中的方法，可通过此方法添加
 *
 *  @param delegate id<UITableViewDataSource, UITableViewDelegate>
 */
- (void)addTableViewAOPDelegate:(id)delegate;

@end

NS_ASSUME_NONNULL_END
