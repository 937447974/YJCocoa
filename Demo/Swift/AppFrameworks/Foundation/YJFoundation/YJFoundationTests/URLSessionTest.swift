//
//  URLSessionTest.swift
//  YJFoundationTests
//
//  Created by 阳君 on 2019/6/17.
//  Copyright © 2019 YJCocoa. All rights reserved.
//

import XCTest
import YJCocoa

class URLSessionTest: XCTestCase {
    
    struct YJTestURLRequestModel {
        var name: String
        var qq: String
    }
    
    struct YJTestURLResponseModel {
        var desc: String?
    }
    
    class YJTestURLSessionTask: YJURLSessionTask {
        override func resume() {
            guard self.state != .running else {
                return
            }
            super.resume()
            dispatch_after_default(delayInSeconds: 1) {
                let json = "{\"desc\": \"服务器回调\"}"
                self.success(json)
            }
        }
    }
    
    func testURLSession() {
        let reqModel = YJTestURLRequestModel(name: "阳君", qq: "557445088")
        let reqDict = YJJSONModel.transformToDict(reqModel)
        let request = YJURLRequest(source: nil, url: "https://github.com/937447974/YJCocoa", method: .post, reqModel: reqDict, respModel: YJTestURLResponseModel())
        let task = YJTestURLSessionTask.task(with: request)
        task.completionHandler(success: { (respModel) in
            print(respModel)
        }, failure: { (error) in
            print("错误")
        }).resume()
    }
    
    func testQueue() {
        for _ in 0..<30 { //合并网络请求
            self.testURLSession()
        }
        sleep(2)
    }
    
}
