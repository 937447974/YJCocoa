//
//  NSLayoutConstraint+YJAutoLayout.h
//  YJAutoLayout
//
//  HomePage:https://github.com/937447974/YJCocoa
//  YJ技术支持群:557445088
//
//  Created by 阳君 on 16/4/22.
//  Copyright © 2016年 YJCocoa. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YJNSLayoutConstraintAnimate.h"

NS_ASSUME_NONNULL_BEGIN

typedef NSLayoutConstraint * _Nonnull (^ Constant)(CGFloat constant);
typedef NSLayoutConstraint * _Nonnull (^ Multiplier)(CGFloat multiplier);

/** NSLayoutConstraint扩展*/
@interface NSLayoutConstraint (YJAutoLayout)

@property (nonatomic, readonly) Constant constants;     ///< 修改constant的值
@property (nonatomic, readonly) Multiplier multipliers; ///< 修改multiplier的值

/**
 *  动画修改约束值
 *
 *  @param duration 时间(秒)
 *  @param constant 修改后的值
 *  @param completion 完成回调
 */
- (void)animateWithDuration:(NSTimeInterval)duration constant:(CGFloat)constant completion:(nullable YJTConstraintAnimateCompletion)completion;

/**
 *  取消动画修改约束值
 */
- (void)animateCancel;

#pragma mark - (+)
/**
 *  搜索NSLayoutConstraint
 *
 *  @return NSLayoutConstraint
 */
+ (nullable instancetype)findConstraintWithItem:(id)view1 attribute:(NSLayoutAttribute)attr1 toItem:(nullable id)view2 attribute:(NSLayoutAttribute)attr2;

#pragma mark NSLayoutRelationEqual
/**
 *  relatedBy = NSLayoutRelationEqual;view2 = nil; multiplier = 1;
 *
 *  @return NSLayoutConstraint
 */
+ (instancetype)constraintWithItem:(id)view1 attribute:(NSLayoutAttribute)attr1 equalToConstant:(CGFloat)c;

/**
 *  relatedBy = NSLayoutRelationEqual; multiplier = 1; constant = 0;
 *
 *  @return NSLayoutConstraint
 */
+ (instancetype)constraintWithItem:(id)view1 attribute:(NSLayoutAttribute)attr1 equalToItem:(nullable id)view2 attribute:(NSLayoutAttribute)attr2;

/**
 *  relatedBy = NSLayoutRelationEqual; multiplier = 1;
 *
 *  @return NSLayoutConstraint
 */
+ (instancetype)constraintWithItem:(id)view1 attribute:(NSLayoutAttribute)attr1 equalToItem:(nullable id)view2 attribute:(NSLayoutAttribute)attr2 constant:(CGFloat)c;

/**
 *  relatedBy = NSLayoutRelationEqual;
 *
 *  @return NSLayoutConstraint
 */
+ (instancetype)constraintWithItem:(id)view1 attribute:(NSLayoutAttribute)attr1 equalToItem:(nullable id)view2 attribute:(NSLayoutAttribute)attr2 multiplier:(CGFloat)multiplier constant:(CGFloat)c;

#pragma mark NSLayoutRelationLessThanOrEqual
/**
 *  relatedBy = NSLayoutRelationEqual;view2 = nil; multiplier = 1;
 *
 *  @return NSLayoutConstraint
 */
+ (instancetype)constraintWithItem:(id)view1 attribute:(NSLayoutAttribute)attr1 lessThanOrEqualToConstant:(CGFloat)c;

/**
 *  relatedBy = NSLayoutRelationLessThanOrEqual; multiplier = 1; constant = 0;
 *
 *  @return NSLayoutConstraint
 */
+ (instancetype)constraintWithItem:(id)view1 attribute:(NSLayoutAttribute)attr1 lessThanOrEqualToItem:(nullable id)view2 attribute:(NSLayoutAttribute)attr2;

/**
 *  relatedBy = NSLayoutRelationLessThanOrEqual; multiplier = 1;
 *
 *  @return NSLayoutConstraint
 */
+ (instancetype)constraintWithItem:(id)view1 attribute:(NSLayoutAttribute)attr1 lessThanOrEqualToItem:(nullable id)view2 attribute:(NSLayoutAttribute)attr2 constant:(CGFloat)c;

/**
 *  relatedBy = NSLayoutRelationLessThanOrEqual;
 *
 *  @return NSLayoutConstraint
 */
+ (instancetype)constraintWithItem:(id)view1 attribute:(NSLayoutAttribute)attr1 lessThanOrEqualToItem:(nullable id)view2 attribute:(NSLayoutAttribute)attr2 multiplier:(CGFloat)multiplier constant:(CGFloat)c;

#pragma mark NSLayoutRelationGreaterThanOrEqual
/**
 *  relatedBy = NSLayoutRelationGreaterThanOrEqual;view2 = nil; multiplier = 1;
 *
 *  @return NSLayoutConstraint
 */
+ (instancetype)constraintWithItem:(id)view1 attribute:(NSLayoutAttribute)attr1 greaterThanOrEqualToConstant:(CGFloat)c;

/**
 *  relatedBy = NSLayoutRelationGreaterThanOrEqual; multiplier = 1; constant = 0;
 *
 *  @return NSLayoutConstraint
 */
+ (instancetype)constraintWithItem:(id)view1 attribute:(NSLayoutAttribute)attr1 greaterThanOrEqualToItem:(nullable id)view2 attribute:(NSLayoutAttribute)attr2;

/**
 *  relatedBy = NSLayoutRelationGreaterThanOrEqual; multiplier = 1;
 *
 *  @return NSLayoutConstraint
 */
+ (instancetype)constraintWithItem:(id)view1 attribute:(NSLayoutAttribute)attr1 greaterThanOrEqualToItem:(nullable id)view2 attribute:(NSLayoutAttribute)attr2 constant:(CGFloat)c;

/**
 *  relatedBy = NSLayoutRelationGreaterThanOrEqual;
 *
 *  @return NSLayoutConstraint
 */
+ (instancetype)constraintWithItem:(id)view1 attribute:(NSLayoutAttribute)attr1 greaterThanOrEqualToItem:(nullable id)view2 attribute:(NSLayoutAttribute)attr2 multiplier:(CGFloat)multiplier constant:(CGFloat)c;

@end

NS_ASSUME_NONNULL_END
