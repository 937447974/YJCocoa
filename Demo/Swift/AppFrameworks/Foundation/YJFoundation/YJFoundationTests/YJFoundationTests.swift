//
//  YJFoundationTests.swift
//  YJFoundationTests
//
//  Created by 阳君 on 2019/5/28.
//  Copyright © 2019 YJCocoa. All rights reserved.
//

import XCTest
@testable import YJCocoa

class YJFoundationTests: XCTestCase {
    
    func testDirectory() {
        let director = YJNSDirectoryS()
        XCTAssertNotNil(director.homeURL)
        XCTAssertNotNil(director.documentURL)
        XCTAssertNotNil(director.libraryURL)
        XCTAssertNotNil(director.cachesURL)
        XCTAssertNotNil(director.tempURL)
        print("homeURL: \(director.homeURL!))")
        print("documentURL: \(director.documentURL!))")
        print("libraryURL: \(director.libraryURL!))")
        print("cachesURL: \(director.cachesURL!))")
        print("tempURL: \(director.tempURL!))")
    }
    
    func testURL() {
        print(YJNSURL.assemblyParams(nil, params: ["wd" : "阳君"], encode: false))
        print(YJNSURL.assemblyParams("http://www.baidu.com", params: [:], encode: true))
        print(YJNSURL.assemblyParams("http://www.baidu.com?rsv_sug7=101", params: ["wd":"阳君"], encode: true))
        print(YJNSURL.analysisParams("https://www.baidu.com?rsv_sug7=101&wd=%E9%98%B3%E5%90%9B", decode: true))
    }
    
}
