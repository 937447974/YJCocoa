//
//  DoubleExt.swift
//  YJCocoa
//
//  HomePage:https://github.com/937447974/YJCocoa
//  YJ技术支持群:557445088
//
//  Created by 阳君 on 2019/9/18.
//  Copyright © 2016-现在 YJCocoa. All rights reserved.
//

import UIKit

public extension Double {
    
    /// 四舍五入保留小数位置
    func rounded(decimal: Int) -> Double {
        let divisor = pow(10.0, Double(decimal))
        return (self * divisor).rounded() / divisor
    }
    
}
