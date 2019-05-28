//
//  DirectoryTest.swift
//  YJFoundationTests
//
//  Created by 阳君 on 2019/5/27.
//  Copyright © 2019 YJCocoa. All rights reserved.
//

import XCTest
import YJCocoa

class DirectoryTest: XCTestCase {
    
    func testExample() {
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
    
}
