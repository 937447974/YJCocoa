//
//  UIScrollViewExt.swift
//  YJCocoa
//
//  HomePage:https://github.com/937447974/YJCocoa
//  YJ技术支持群:557445088
//
//  Created by 阳君 on 2019/9/2.
//  Copyright © 2016-现在 YJCocoa. All rights reserved.
//

import UIKit

extension UIScrollView: UIGestureRecognizerDelegate {
    
    open func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRequireFailureOf otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        guard otherGestureRecognizer.isKind(of: UIScreenEdgePanGestureRecognizer.self) else {
            return false
        }        
        if CGAffineTransform(rotationAngle: CGFloat(-Double.pi*0.5)) == self.transform || CGAffineTransform(rotationAngle: CGFloat(Double.pi*0.5)) == self.transform {
            return false
        }
        return self.contentOffset.x <= 0 || gestureRecognizer.view!.isKind(of: NSClassFromString("_UIQueuingScrollView")!)
    }
    
}
