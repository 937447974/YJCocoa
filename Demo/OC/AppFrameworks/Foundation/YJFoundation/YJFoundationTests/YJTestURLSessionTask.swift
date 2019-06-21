//
//  YJTestURLSessionTask.swift
//  YJFoundationTests
//
//  Created by 阳君 on 2019/6/21.
//  Copyright © 2019 YJCocoa. All rights reserved.
//

import UIKit
import YJCocoa

@objcMembers
class YJTestURLRequestModel: NSObject {
    var name: String = ""
    var qq: String = ""
}

@objcMembers
class YJTestURLResponseModel: NSObject {
    var desc: String?
}

class YJTestURLSessionTask: YJURLSessionTask {
    override func resume() {
        guard self.state != .running else {
            return
        }
        super.resume()
        let json = "{\"desc\": \"服务器回调\"}"
        self.success(json)
    }
}
