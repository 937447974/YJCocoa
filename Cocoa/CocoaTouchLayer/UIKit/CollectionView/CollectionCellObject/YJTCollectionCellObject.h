//
//  YJTCollectionCellObject.h
//  YJTCollectionView
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
@protocol YJTCollectionCellModel <NSObject>

@end

/** 创建cell的方式*/
typedef NS_ENUM(NSInteger, YJTCollectionCellCreate) {
    YJTCollectionCellCreateDefault,   ///< 默认使用xib创建cell，推荐此方式
    YJTCollectionCellCreateSoryboard, ///< 使用soryboard创建cell时，请使用类名作为标识符
    YJTCollectionCellCreateClass      ///< 使用Class创建cell,即使用[[UICollectionViewCell alloc] initWithFrame:CGRectZero]创建cell
};

/** UICollectionViewCell封装对象*/
@interface YJTCollectionCellObject : NSObject

@property (nonatomic) id<YJTCollectionCellModel> cellModel; ///< cell对应的VM
@property (nonatomic) YJTCollectionCellCreate createCell;   ///< 创建cell的方式
@property (nonatomic, strong, nullable) id userInfo;        ///< 携带的数据

@property (nonatomic, strong, nullable) NSIndexPath *indexPath; ///< cell所处位置，无须添加，自动填充

@property (nonatomic, readonly) Class cellClass;          ///< UICollectionViewCell对应的类
@property (nonatomic, copy, readonly) NSString *cellName; ///< UICollectionViewCell对应的类名

/**
 *  初始化YJTCollectionCellObject
 *
 *  @param cellClass YJTableViewCell对应的类
 *
 *  @return void
 */
- (instancetype)initWithCollectionViewCellClass:(Class)cellClass;

@end

NS_ASSUME_NONNULL_END
