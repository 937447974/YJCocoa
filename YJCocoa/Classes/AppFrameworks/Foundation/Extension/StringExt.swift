//
//  StringExt.swift
//  YJCocoa
//
//  Created by 阳君 on 2019/5/29.
//

import UIKit

extension String {
    
    public subscript(r: Range<Int>) ->String {
        let start = self.index(self.startIndex, offsetBy: r.lowerBound)
        let end = self.index(self.startIndex, offsetBy: r.upperBound)
        return String(self[start..<end])
    }
    
}
