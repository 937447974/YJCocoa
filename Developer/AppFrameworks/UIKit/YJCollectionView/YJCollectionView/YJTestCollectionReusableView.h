//
//  YJTestCollectionReusableView.h
//  YJCollectionView
//
//  Created by 阳君 on 16/7/8.
//  Copyright © 2016年 YJ. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YJUICollectionView.h"

@interface YJTestCollectionReusableViewModel : NSObject <YJTCollectionCellModel>

@property (nonatomic, strong) UIColor *backgroundColor; ///< 背景色

@end

@interface YJTestCollectionReusableView : UICollectionReusableView

@end
