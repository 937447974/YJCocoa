//
//  YJTest2CollectionViewCell.m
//  YJCollectionView
//
//  Created by admin on 2016/12/6.
//  Copyright © 2016年 YJ. All rights reserved.
//

#import "YJTest2CollectionViewCell.h"

@implementation YJTest2CollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor greenColor];
        self.label = [[UILabel alloc] initWithFrame:self.bounds];
        [self.contentView addSubview:self.label];
        self.label.font = [UIFont systemFontOfSize:20];
        self.label.textAlignment = NSTextAlignmentCenter;
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    self.label.frame = self.bounds;
}

+ (YJUICollectionCellCreate)cellCreate {
    return YJUICollectionCellCreateClass;
}

- (void)reloadDataSyncWithCellObject:(YJUICollectionCellObject *)cellObject collectionViewManager:(YJUICollectionViewManager *)collectionViewManager {
    [super reloadDataSyncWithCellObject:cellObject collectionViewManager:collectionViewManager];
    YJTestCollectionCellModel *cellModel = cellObject.cellModel;
    self.label.text = cellModel.index;
}

@end
