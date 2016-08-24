//
//  YJTestCollectionViewCell.h
//  YJCollectionView
//
//  Created by 阳君 on 16/5/21.
//  Copyright © 2016年 YJ. All rights reserved.
//

#import "YJTCollectionViewCell.h"

NS_ASSUME_NONNULL_BEGIN

@interface YJTestCollectionCellModel : NSObject <YJTCollectionCellModel>

@property (nonatomic, copy) NSString *index; ///< 位置

@end


@interface YJTestCollectionViewCell : YJTCollectionViewCell

@property (weak, nonatomic) IBOutlet UILabel *label;

@end

NS_ASSUME_NONNULL_END