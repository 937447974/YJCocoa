//
//  YJSDictionaryModel.m
//  YJSFoundation
//
//  Created by admin on 2016/9/26.
//  Copyright © 2016年 YJCocoa. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "YJSFoundation.h"

@interface MyModel1 : NSObject
@property (nonatomic, copy) NSString *userID;
@property (nonatomic, copy) NSString *name;
@property (nonatomic) NSInteger qq;
@property (nonatomic) CGFloat f;
@property (nonatomic) BOOL b;
@end

@implementation MyModel1

+ (NSString *)getDictKeyWithAttributeName:(NSString *)attributeName {
    if ([@"userID" isEqualToString:attributeName]) {
        return @"user_id"; // 服务器回传的用户id用user_id表示。当前模型用userID接收
    }
    return [super getDictKeyWithAttributeName:attributeName];
}

+ (NSSet<NSString *> *)ignoredAttributes {
    NSMutableSet *set = [[NSMutableSet alloc] initWithSet:[super ignoredAttributes]];
    [set addObject:@"b"]; // 忽略b属性
    return set;
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
@end

@implementation MyModel2

+ (Class)getImportArrayClassWithAttributeName:(NSString *)attributeName {
    if ([@"array2" isEqualToString:attributeName]) {
        return [MyModel1 class]; // 返回array2中存放的模型class
    }
    return [super getImportArrayClassWithAttributeName:attributeName];
}

@end

#pragma mark -

@interface YJSDictionaryModel : XCTestCase

@end

@implementation YJSDictionaryModel

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testExample {
    // This is an example of a functional test case.
    // Use XCTAssert and related functions to verify your tests produce the correct results.
    MyModel1 *m1 = [[MyModel1 alloc] init];
    m1.userID = @"1";
    m1.f = 2;
    MyModel2 *m2 = [[MyModel2 alloc] init];
    m2.name = @"阳君";
    m2.qq = 937447974;
    m2.array2 = @[@[m1]].mutableCopy;
    
    NSLogS(m1.modelDictionary);
    NSDictionary *dict = m2.modelDictionary;
    NSLogS(dict);
    
    MyModel2 *m3 = [[MyModel2 alloc] initWithModelDictionary:dict];
    NSLogS(m3.modelDictionary);
    
    // 非法数据
    MyModel2 *m4 = [[MyModel2 alloc] initWithModelDictionary:@{@"user_id":@(2), @"f":@"3"}];
    NSLogS(m4.modelDictionary);
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

@end

