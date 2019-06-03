//
//  YJSystemTests.swift
//  YJSystemTests
//
//  Created by 阳君 on 2019/5/30.
//  Copyright © 2019 YJCocoa. All rights reserved.
//

import XCTest
@testable import YJCocoa

class YJSystemTests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    
    func testDispatch() {
        dispatch_async_main {
            print("main: \(Thread.isMainThread)")
        }
        dispatch_async_default {
            print("default: \(Thread.isMainThread)")
        }
        for i in 0..<5 {
            dispatch_async_concurrent {
                print("concurrent 1: \(i)")
            }
            dispatch_async_concurrent {
                print("concurrent 2: \(i)")
                sleep(2)
            }
            dispatch_async_serial {
                print("serial 1: \(i)")
            }
            dispatch_async_serial {
                print("serial 2: \(i)")
                sleep(1)
            }
        }
    }
    
    func testRandom() {
        print(YJSecRandomU(count: 8))
        print(YJSecRandomL(count: 8))
        print(YJSecRandomUL(count: 8))
    }
    
    func testKeyChain() {
        func buildItem() -> YJSecKeychainItem {
            let item = YJSecKeychainItem.buildGenericPassword()
            item.account = "阳君"
            return item
        }
        func select() {
            print("find: \(String(describing: YJSecKeychainSelect(item: buildItem())))")
        }
        func save() {
            let item = buildItem()
            item.desc = "设置描述"
            print("save: \(YJSecKeychainSave(item: item))")
        }
        func update() {
            let item = buildItem()
            item.comment = "设置注释"
            print("save: \(YJSecKeychainSave(item: item))")
        }
        func delete() {
            print("delete: \(YJSecKeychainDelete(item: buildItem()))")
        }
        select()
        save()
        select()
        update()
        select()
        delete()
        select()
    }


}
