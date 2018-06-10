//
//  YJUICollectionViewDelegateManager.h
//  YJCollectionView
//
//  HomePage:https://github.com/937447974/YJCocoa
//  YJ技术支持群:557445088
//
//  Created by 阳君 on 2016/10/18.
//  Copyright © 2016年 YJCocoa. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YJUICollectionViewCell.h"

@class YJUICollectionViewManager;

/** UICollectionViewDelegate管理器*/
@interface YJUICollectionViewDelegateManager : NSObject <UICollectionViewDelegate>

@property (nonatomic, weak, readonly) YJUICollectionViewManager *manager; ///< YJUICollectionViewManager

/**
 *  @abstract 初始化
 *
 *  @param manager YJUICollectionViewManager
 *
 *  @return YJUICollectionViewDelegateManager
 */
- (instancetype)initWithManager:(YJUICollectionViewManager *)manager;

@end
