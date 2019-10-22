//
//  YJTouchView.swift
//  Pods
//
//  Created by 阳君 on 2019/9/10.
//

import UIKit

/// 扩展触摸的最大区域
public var YJTouchMax: CGFloat = 44

extension UIView {
    func hitTestTouch(_ point: CGPoint) -> CGPoint {
        var point = point
        if !self.frame.contains(point) {
            let max: CGFloat = YJTouchMax
            let width = self.frame.width > max ? self.frame.width : max
            let height = self.frame.height > max ? self.frame.height : max
            let newFrame = CGRect(x: (self.frame.width - width)/2, y: (self.frame.height - height)/2, width: width, height: height)
            if newFrame.contains(point) {
                point = CGPoint(x: newFrame.midX, y: newFrame.midY)
            }
        }
        return point
    }
}

/** 扩大触摸区域的UIView*/
open class YJTouchView: UIView {
    open override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        return super.hitTest(self.hitTestTouch(point), with: event)
    }
}

/** 扩大触摸区域的UIImageView*/
open class YJTouchImageView: UIImageView {
    open override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        return super.hitTest(self.hitTestTouch(point), with: event)
    }
}

/** 扩大触摸区域的UILabel*/
open class YJTouchLabel: UILabel {
    open override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        return super.hitTest(self.hitTestTouch(point), with: event)
    }
}

/** 扩大触摸区域的UIButton*/
open class YJTouchButton: UIButton {
    open override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        return super.hitTest(self.hitTestTouch(point), with: event)
    }
}

/** 扩大触摸区域的UITextView*/
open class YJTouchTextView: UITextView {
    open override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        return super.hitTest(self.hitTestTouch(point), with: event)
    }
}
