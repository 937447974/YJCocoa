//
//  ArrayExt.swift
//  YJCocoa
//
//  HomePage:https://github.com/937447974/YJCocoa
//  YJ技术支持群:557445088
//
//  Created by 阳君 on 2019/10/8.
//  Copyright © 2016-现在 YJCocoa. All rights reserved.
//

import UIKit

public extension Array where Element == String {
    func object(at index: Int) -> Element {
        guard index < self.count else {
            return ""
        }
        return self[index]
    }
}
