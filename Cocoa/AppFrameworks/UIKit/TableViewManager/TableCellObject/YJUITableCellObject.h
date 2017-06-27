//
//  YJUITableCellObject.h
//  YJUITableViewFactory
//
//  HomePage:https://github.com/937447974/YJCocoa
//  YJ技术支持群:557445088
//
//  Created by 阳君 on 16/5/13.
//  Copyright © 2016年 YJCocoa. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

/** 创建cell的方式*/
typedef NS_ENUM(NSInteger, YJUITableViewCellCreate) {
    YJUITableViewCellCreateClass,    ///< 使用Class创建cell,即使用[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:className]创建cell
    YJUITableViewCellCreateXib,      ///< 默认使用xib创建cell
    YJUITableViewCellCreateSoryboard ///< 使用soryboard创建cell时，请使用类名作为标识符
};


/** cell模型协议*/
@protocol YJUITableCellModelProtocol <NSObject>

@end


/** TableCell对象*/
@interface YJUITableCellObject : NSObject

@property (nonatomic, copy) NSString *reuseIdentifier; ///< UITableViewCell.reuseIdentifier，默认类名

@property (nonatomic, strong) id<YJUITableCellModelProtocol> cellModel; ///< cell对应的VM
@property (nonatomic, strong, nullable) id userInfo;                    ///< 携带的自定义数据

@property (nonatomic) YJUITableViewCellCreate createCell; ///< 创建cell的方式
@property (nonatomic, strong) NSIndexPath *indexPath;     ///< cell所处位置，无须添加，自动填充

@property (nonatomic, readonly)       Class cellClass;    ///< UITableViewCell对应的类
@property (nonatomic, copy, readonly) NSString *cellName; ///< UITableViewCell对应的类名

/**
 *  @abstract 初始化YJUITableCellObject，当不想创建子类时，可使用此方法创建对象
 *
 *  @param cellClass YJUITableViewCell对应的类
 */
- (instancetype)initWithTableViewCellClass:(Class)cellClass;

@end

NS_ASSUME_NONNULL_END
