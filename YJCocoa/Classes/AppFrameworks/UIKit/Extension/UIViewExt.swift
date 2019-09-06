//
//  UIViewExt.swift
//  YJCocoa
//
//  HomePage:https://github.com/937447974/YJCocoa
//  YJ技术支持群:557445088
//
//  Created by 阳君 on 2019/5/23.
//  Copyright © 2019 YJCocoa. All rights reserved.
//

import UIKit

// MARK: Geometry
@objc public extension UIView {
    
    // MARK: frame
    /// .frame.origin.x
    var frameLeft: CGFloat {
        get {return self.frame.origin.x}
        set {self.frame.origin.x = newValue}
    }
    /// .frameLeft + .frameWidth
    var frameRight: CGFloat {
        get {return self.frameLeft + self.frameWidth}
        set {self.frameLeft = newValue - self.frameWidth}
    }
    /// .frame.origin.y
    var frameTop: CGFloat {
        get {return self.frame.origin.y}
        set {self.frame.origin.y = newValue}
    }
    /// .frameTop + .heighteFrame
    var frameBottom: CGFloat {
        get {return self.frameTop + self.frameHeight}
        set {self.frameTop = newValue - self.frameHeight}
    }
    
    /// .frame.size.width
    var frameWidth: CGFloat {
        get {return self.frame.size.width}
        set {self.frame.size.width = newValue}
    }
    /// .frame.size.height
    var frameHeight: CGFloat {
        get {return self.frame.size.height}
        set {self.frame.size.height = newValue}
    }
    
    /// .frame.origin
    var frameOrigin: CGPoint {
        get {return self.frame.origin}
        set {self.frame.origin = newValue}
    }
    /// .frame.size
    var frameSize: CGSize {
        get {return self.frame.size}
        set {self.frame.size = newValue}
    }
    
    // MARK: center
    /// .center.x
    var centerX: CGFloat {
        get {return self.center.x}
        set {self.center.x = newValue}
    }
    /// .center.y
    var centerY: CGFloat {
        get {return self.center.y}
        set {self.center.y = newValue}
    }
    
    // MARK: bounds
    /// .bounds.origin.x
    var boundsLeft: CGFloat {
        get {return self.bounds.origin.x}
        set {self.bounds.origin.x = newValue}
    }
    /// .bounds.origin.y
    var boundsTop: CGFloat {
        get {return self.bounds.origin.y}
        set {self.bounds.origin.y = newValue}
    }
    /// .bounds.size.width
    var boundsWidth: CGFloat {
        get {return self.bounds.size.width}
        set {self.bounds.size.width = newValue}
    }
    /// .bounds.size.height
    var boundsHeight: CGFloat {
        get {return self.bounds.size.height}
        set {self.bounds.size.height = newValue}
    }
    
    func frameOriginInWindow() -> CGPoint {
        return self.frameOrigin(in: UIApplication.shared.keyWindow!)
    }
    
    /// 获取相对view的origin，当前view是相对view的子view
    func frameOrigin(in view: UIView) -> CGPoint {
        var origin = self.frameOrigin
        var sv = self.superview
        while sv != nil && sv == view {
            origin.x += sv!.frameLeft
            origin.y += sv!.frameTop
            if let scrollView = sv as? UIScrollView {
                origin.x += scrollView.contentOffset.x
                origin.y += scrollView.contentOffset.y
            }
            sv = sv!.superview
        }
        return origin
    }
    
}

public extension UIView {
    
    /// 移除所有子视图
    func removeAllSubviews() {
        for view in self.subviews {
            view.removeFromSuperview()
        }
    }
    
    /// 圆角设置
    func setCornerRadius(_ cornerRadius: CGFloat, masksToBounds: Bool = true) {
        self.layer.cornerRadius = cornerRadius
        self.layer.masksToBounds = masksToBounds
    }
    
    /// 圆角设置
    func setCornerRadius(_ cornerRadius: CGFloat, byRoundingCorners corners: UIRectCorner) {
        let maskPath = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: cornerRadius, height: cornerRadius))
        let maskLayer = CAShapeLayer(layer: self.layer)
        maskLayer.path = maskPath.cgPath
        self.layer.mask = maskLayer
    }
    
    /// 投影设置
    func setShadow(color: UIColor, offset: CGSize, radius: CGFloat, opacity: Float) {
        self.layer.masksToBounds = false
        self.layer.shadowColor = color.cgColor
        self.layer.shadowOffset = offset
        self.layer.shadowRadius = radius
        self.layer.shadowOpacity = opacity
    }
    
    
    
}
