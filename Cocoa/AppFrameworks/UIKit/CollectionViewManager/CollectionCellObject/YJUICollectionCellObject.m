//
//  YJUICollectionCellObject.m
//  YJUICollectionView
//
//  HomePage:https://github.com/937447974/YJCocoa
//  YJ技术支持群:557445088
//
//  Created by 阳君 on 16/5/21.
//  Copyright © 2016年 YJCocoa. All rights reserved.
//

#import "YJUICollectionCellObject.h"
#import "YJNSFoundationOther.h"

@implementation YJUICollectionCellObject

- (instancetype)initWithCollectionViewCellClass:(Class)cellClass {
    self = [super init];
    if (self) {
        _cellClass = cellClass;
        _cellName = YJNSStringFromClass(_cellClass);
    }
    return self;
}

@end
