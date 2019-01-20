//
//  YJNSRouterUnregistered.h
//  YJCocoa
//
//  HomePage:https://github.com/937447974/YJCocoa
//  YJ技术支持群:557445088
//
//  Created by 阳君 on 2019/1/5.
//  Copyright © 2019年 YJCocoa. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YJNSURLRouterProtocol.h"

NS_ASSUME_NONNULL_BEGIN

@interface YJNSRouterUnregistered : NSObject

@property (nonatomic, copy) YJRUnregisteredCanOpen canOpen;
@property (nonatomic, copy) YJROpenHandler openHandler;

@end

NS_ASSUME_NONNULL_END
