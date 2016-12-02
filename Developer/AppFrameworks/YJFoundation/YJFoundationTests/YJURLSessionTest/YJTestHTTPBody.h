//
//  YJTestHTTPBody.h
//  YJFoundation
//
//  Created by 阳君 on 2016/11/30.
//  Copyright © 2016年 YJCocoa. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YJNSHTTPBodyProtocol.h"
#import "YJTestModel.h"

@interface YJTestHTTPBody : NSObject <YJNSHTTPBodyProtocol>

@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *qq;

@end
