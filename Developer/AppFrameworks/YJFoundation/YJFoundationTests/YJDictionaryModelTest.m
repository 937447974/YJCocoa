//
//  YJDictionaryModelTest.m
//  YJFoundation
//
//  Created by 阳君 on 2016/10/10.
//  Copyright © 2016年 YJCocoa. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "YJFoundation.h"

@interface MyModel1 : NSObject
@property (nonatomic, copy) NSString *userID;
@property (nonatomic, copy) NSString *name;
@property (nonatomic) NSInteger qq;
@property (nonatomic) CGFloat f;
@property (nonatomic) BOOL b;
@end

@implementation MyModel1

+ (YJNSDictionaryModelManager *)dictionaryModelManager {
    YJNSDictionaryModelManager *dMManager = [[YJNSDictionaryModelManager alloc] init];
    // 服务器回传的用户id用user_id表示。当前模型用userID接收
    dMManager.optionalAttributes = [NSDictionary dictionaryWithObject:@"user_id" forKey:@"userID"];
    dMManager.ignoredAttributes = [NSSet setWithObject:@"b"];// 忽略b属性
    return dMManager;
}

@end

#pragma mark -

@interface MyModel2 : MyModel1
@property (nonatomic, strong) MyModel1 *obj; ///<
@property (nonatomic, strong) NSArray *array1; ///<
@property (nonatomic, strong) NSMutableArray<NSArray<MyModel1 *> *> *array2; ///<
@property (nonatomic, strong) NSDictionary *dict; ///<
@property (nonatomic) UITableViewStyle style;
@property (nonatomic, weak) id <UITableViewDataSource> dataSource;
@property (nonatomic, weak, nullable) id <UITableViewDelegate> delegate;
@property (nonatomic, copy) void (^ __nullable block)(BOOL finished);
@property (nonatomic, copy) NSArray *(^ __nullable block2)(BOOL finished);
@property (nonatomic, strong) NSURL *httpURL; ///<
@property (nonatomic, strong) NSURL *fileURL; ///<

@end

@implementation MyModel2

+ (YJNSDictionaryModelManager *)dictionaryModelManager {
    YJNSDictionaryModelManager *dMManager = [[YJNSDictionaryModelManager alloc] init];
    // array2中存放的模型class
    dMManager.importArrayClasses = [NSDictionary dictionaryWithObject:[MyModel1 class] forKey:@"array2"];
    return dMManager;
}

@end

#pragma mark -

@interface YJDictionaryModelTest : XCTestCase

@end

@implementation YJDictionaryModelTest

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testExample {
    MyModel1 *m1 = [[MyModel1 alloc] init];
    m1.userID = @"1";
    m1.f = 2;
    MyModel2 *m2 = [[MyModel2 alloc] init];
    m2.name = @"阳君";
    m2.qq = 937447974;
    m2.array1 = @[@"array11",@"array12"];
    m2.array2 = @[@[m1]].mutableCopy;
    m2.httpURL = [NSURL URLWithString:@"https://github.com/937447974/YJCocoa"];
    m2.fileURL = [NSURL fileURLWithPath:@"/Users/admin/Library/Developer/CoreSimulator/Devices"];
    
    NSLogS(m1.modelDictionary);
    
    NSDictionary *dict = m2.modelDictionary;
    NSLogS(dict);
    MyModel2 *m3 = [[MyModel2 alloc] initWithModelDictionary:dict];
    NSLogS(m3.modelDictionary);
    
    // 非法数据
    MyModel2 *m4 = [[MyModel2 alloc] initWithModelDictionary:@{@"user_id":@(2), @"f":@"3"}];
    NSLogS(m4.modelDictionary);
}

@end
