//
//  CGGeometryExt.swift
//  Pods
//
//  Created by 阳君 on 2019/12/24.
//

import UIKit

public extension CGSize {
    var center: CGPoint {
        return CGPoint(x: self.width / 2, y: self.height / 2)
    }
}
