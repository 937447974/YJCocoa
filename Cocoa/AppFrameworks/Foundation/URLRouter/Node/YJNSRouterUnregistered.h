//
//  YJNSRouterUnregistered.h
//  YJCocoa
//
//  Created by CISDI on 2019/1/5.
//

#import <Foundation/Foundation.h>
#import "YJNSURLRouterProtocol.h"

NS_ASSUME_NONNULL_BEGIN

@interface YJNSRouterUnregistered : NSObject

@property (nonatomic, copy) YJRUnregisteredCanOpen canOpen;
@property (nonatomic, copy) YJROpenHandler openHandler;

@end

NS_ASSUME_NONNULL_END
