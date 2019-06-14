//
//  JSONModelTest.swift
//  YJFoundationTests
//
//  Created by 阳君 on 2019/6/13.
//  Copyright © 2019 YJCocoa. All rights reserved.
//

import XCTest
@testable import YJCocoa
@testable import HandyJSON

class JSONModelTest: XCTestCase {
    
    struct TestItem: YJJSONModelTransformBasic {
        // 基础类型的struct、class填充到 var array2: Array<TestItem>?，
        // 只需继承 YJJSONModelTransformBasic, 实现相关协议即可完成自解包操作
        var name: String?
        
        init() {}
        init(name: String?) {
            self.name = name
        }
        
        static func transform(fromJSON value: Any) -> Any? {
            return YJJSONModel<TestItem>.transformToModel(TestItem(), fromDict: value as? [String: Any])
        }
        
        static func transform(toJSON value: Any) -> Any {
            return YJJSONModel<TestItem>.transformToDict(value)
        }
        
    }
    
    struct TestStruct: HandyJSON {
        var bool: Bool = false
        var int: Int = 0
        var float: Float = 0
        var cgFloat: CGFloat = 0
        var double: Double = 0
//        var string: String?
    }
    
    class TestClass: NSObject {
        var bool: Bool = false
        var int: Int?
        var float: Float?
        var cgFloat: CGFloat?
        var double: Double?
        var string: String?
        var array1: Array<Any>?
        var array2: Array<TestItem>?
        var url: URL?
        var date: Date?
        var color: UIColor?
        var item: TestItem?
        
        override init() {
            
        }
        
        init(bool: Bool, int: Int, float: Float, cgFloat: CGFloat, double: Double, string: String?) {
            self.bool = bool
            self.int = int
            self.float = float
            self.cgFloat = cgFloat
            self.double = double
            self.string = string
        }
        
        func set(array1: Array<Any>?, array2: Array<TestItem>?, url: URL?, date: Date?, color: UIColor?, item: TestItem?) {
            self.array1 = array1
            self.array2 = array2
            self.url = url
            self.date = date
            self.color = color
            self.item = item
        }
        
    }
    
    func headPointer(_ object: inout TestStruct) -> UnsafeMutablePointer<Int8> {
        let stride = MemoryLayout.stride(ofValue: object)
        return withUnsafeMutablePointer(to: &object) {
            return UnsafeMutableRawPointer($0).bindMemory(to: Int8.self, capacity: stride)
        }
    }
    
    func testStruct() {
        var ts = TestStruct(bool: false, int: 1, float: 2, cgFloat: 3, double: 4)
        print(ts.headPointerOfStruct())
        
        print(self.headPointer(&ts))
        
        
        HandyJSONConfiguration.debugMode = .verbose

//        let json1 = ts.toJSONString()
//        let json2 = ts.toJSONString()
        let json3 = ts.toJSONString()
//        var t = ts
//        let json4 = t.toJSONString()
//        print(TestStruct.deserialize(from: json3))
        YJLogDebug("\(json3)")
        print(self.headPointer(&ts))
        let json = YJJSONModel<TestStruct>.transformToDict(ts)
//        XCTAssertNil(json)
        YJLogDebug("\(json)")
    }
    
    func testClass() {
        // model -> json
        let ts = TestClass(bool: true, int: 1, float: 2, cgFloat: 3, double: 4, string: "阳君")
        ts.set(array1: ["array1"], array2: [TestItem(name: "array2")], url: URL(string: "http://www.baidu.com"), date: Date(), color: UIColor.red, item: TestItem(name: "item"))
        let json = YJJSONModel<TestClass>.transformToJSON(ts)
        XCTAssertNotNil(json)
        YJLogDebug(json!)
        // json -> model
        let jm = YJJSONModel<TestClass>.transformToModel(TestClass(), fromJSON: json)
        XCTAssertNotNil(jm.int)
        XCTAssertNotNil(jm.float)
        XCTAssertNotNil(jm.cgFloat)
        XCTAssertNotNil(jm.double)
        XCTAssertNotNil(jm.string)
        XCTAssertNotNil(jm.array1?.first)
        XCTAssertNotNil(jm.array2?.first?.name)
        XCTAssertNotNil(jm.url)
        XCTAssertNotNil(jm.date)
        XCTAssertNotNil(jm.color)
        XCTAssertNotNil(jm.item?.name)
    }
    
}
