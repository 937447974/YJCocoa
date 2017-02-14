//
//  YJUICollectionCellObject.h
//  YJUICollectionView
//
//  HomePage:https://github.com/937447974/YJCocoa
//  YJ技术支持群:557445088
//
//  Created by 阳君 on 16/5/21.
//  Copyright © 2016年 YJCocoa. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

/** cell模型协议*/
@protocol YJUICollectionCellModel <NSObject>

@end

/** 创建cell的方式*/
typedef NS_ENUM(NSInteger, YJUICollectionCellCreate) {
    YJUICollectionCellCreateClass,     ///< 使用Class创建cell,即使用[[UICollectionViewCell alloc] initWithFrame:CGRectZero]创建cell
    YJUICollectionCellCreateXib,       ///< 默认使用xib创建cell
    YJUICollectionCellCreateStoryboard ///< 使用soryboard创建cell时，请使用类名作为标识符
};

/** UICollectionViewCell封装对象*/
@interface YJUICollectionCellObject : NSObject

@property (nonatomic, strong) id<YJUICollectionCellModel> cellModel; ///< cell对应的VM
@property (nonatomic, strong, nullable) id userInfo;                 ///< 携带的数据

@property (nonatomic) YJUICollectionCellCreate createCell; ///< 创建cell的方式
@property (nonatomic, strong) NSIndexPath *indexPath;      ///< cell所处位置，无须添加，自动填充

@property (nonatomic, readonly) Class cellClass;          ///< UICollectionViewCell对应的类
@property (nonatomic, copy, readonly) NSString *cellName; ///< UICollectionViewCell对应的类名

@property (nonatomic, copy) NSString *reuseIdentifier; ///< UICollectionReusableView.reuseIdentifier，默认类名

/**
 *  初始化YJUICollectionCellObject
 *
 *  @param cellClass YJUIableViewCell对应的类
 *
 *  @return instancetype
 */
- (instancetype)initWithCollectionViewCellClass:(Class)cellClass;

@end

NS_ASSUME_NONNULL_END
