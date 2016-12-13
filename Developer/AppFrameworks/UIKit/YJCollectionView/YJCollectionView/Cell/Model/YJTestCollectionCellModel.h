//
//  YJTestCollectionCellModel.h
//  YJCollectionView
//
//  Created by 阳君 on 2016/12/13.
//  Copyright © 2016年 YJ. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YJUICollectionViewManager.h"

NS_ASSUME_NONNULL_BEGIN

@interface YJTestCollectionCellModel : NSObject <YJUICollectionCellModel>

@property (nonatomic, copy) NSString *index; ///< 位置

@end

NS_ASSUME_NONNULL_END
