//
//  YJTestCollectionViewCell.h
//  YJCollectionView
//
//  Created by 阳君 on 16/5/21.
//  Copyright © 2016年 YJ. All rights reserved.
//

#import "YJUICollectionViewCell.h"

NS_ASSUME_NONNULL_BEGIN

@interface YJTestCollectionCellModel : NSObject <YJUICollectionCellModel>

@property (nonatomic, copy) NSString *index; ///< 位置

@end


@interface YJTestCollectionViewCell : YJUICollectionViewCell

@property (weak, nonatomic) IBOutlet UILabel *label;

@end

NS_ASSUME_NONNULL_END
