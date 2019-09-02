//
//  SetExt.swift
//  YJCocoa
//
//  HomePage:https://github.com/937447974/YJCocoa
//  YJ技术支持群:557445088
//
//  Created by 阳君 on 2019/8/26.
//  Copyright © 2016-现在 YJCocoa. All rights reserved.
//

import UIKit

public extension Set where Element : Hashable {
    
    static func set(with elements: [Element]) -> Set<Element> {
        var result = Set<Element>()
        for element in elements {
            result.insert(element)
        }
        return result
    }
    
}

