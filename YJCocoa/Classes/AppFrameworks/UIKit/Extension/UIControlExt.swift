//
//  UIControlExt.swift
//  Pods
//
//  Created by 阳君 on 2019/6/19.
//

import UIKit

public extension UIControl {
    
    /// 点击回调
    var touchUpInsideClosure:((_ control: Any) -> ())? {
        get {
            let key = UnsafeRawPointer.init(bitPattern: "yj_touchUpInsideClosure".hashValue)!
            return objc_getAssociatedObject(self, key) as? ((Any) -> ())
        }
        set {
            let key = UnsafeRawPointer.init(bitPattern: "yj_touchUpInsideClosure".hashValue)!
            if objc_getAssociatedObject(self, key) == nil {
                self.addTarget(self, action: #selector(UIButton.yjTouchUpInside), for: .touchUpInside)
            }
            objc_setAssociatedObject(self, key, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    
    @objc
    private func yjTouchUpInside() {
        guard let closure = self.touchUpInsideClosure else {
            return
        }
        closure(self)
    }

}
