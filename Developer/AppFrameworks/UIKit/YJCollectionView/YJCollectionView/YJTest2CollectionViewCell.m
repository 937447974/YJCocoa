//
//  YJTest2CollectionViewCell.m
//  YJCollectionView
//
//  Created by admin on 2016/12/6.
//  Copyright © 2016年 YJ. All rights reserved.
//

#import "YJTest2CollectionViewCell.h"

@implementation YJTest2CollectionViewCell

+ (YJUICollectionCellCreate)cellCreate {
    return YJUICollectionCellCreateClass;
}

- (void)reloadDataSyncWithCellObject:(YJUICollectionCellObject *)cellObject collectionViewManager:(YJUICollectionViewManager *)collectionViewManager {
    [super reloadDataSyncWithCellObject:cellObject collectionViewManager:collectionViewManager];
    self.backgroundColor = [UIColor yellowColor];
}

@end
