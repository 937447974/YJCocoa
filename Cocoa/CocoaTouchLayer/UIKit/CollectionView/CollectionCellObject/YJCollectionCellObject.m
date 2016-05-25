//
//  YJCollectionCellObject.m
//  YJCollectionView
//
//  Created by 阳君 on 16/5/21.
//  Copyright © 2016年 YJ. All rights reserved.
//

#import "YJCollectionCellObject.h"
#import "YJFoundationOther.h"

@implementation YJCollectionCellObject

- (instancetype)initWithCollectionViewCellClass:(Class)cellClass {
    self = [super init];
    if (self) {
        _cellClass = cellClass;
        _cellName = YJStringFromClass(_cellClass);
    }
    return self;
}

@end
