//
//  YJUser+CoreDataProperties.h
//  YJCoreData
//
//  Created by admin on 2016/10/29.
//  Copyright © 2016年 YJCocoa. All rights reserved.
//

#import "YJUser+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface YJUser (CoreDataProperties)

+ (NSFetchRequest<YJUser *> *)fetchRequest;

@property (nonatomic) float index;
@property (nullable, nonatomic, copy) NSString *name;
@property (nullable, nonatomic, copy) NSString *qq;

@end

NS_ASSUME_NONNULL_END
