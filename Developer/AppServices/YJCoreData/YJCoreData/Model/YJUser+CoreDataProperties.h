//
//  YJUser+CoreDataProperties.h
//  YJCoreData
//
//  Created by admin on 2016/10/27.
//  Copyright © 2016年 YJCocoa. All rights reserved.
//

#import "YJUser+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface YJUser (CoreDataProperties)

+ (NSFetchRequest<YJUser *> *)fetchRequest;

@property (nullable, nonatomic, copy) NSString *name;

@end

NS_ASSUME_NONNULL_END
