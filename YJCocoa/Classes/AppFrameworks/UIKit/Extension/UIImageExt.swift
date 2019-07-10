//
//  UIImageExt.swift
//  YJCocoa
//
//  HomePage:https://github.com/937447974/YJCocoa
//  YJ技术支持群:557445088
//
//  Created by 阳君 on 2019/6/19.
//  Copyright © 2016-现在 YJCocoa. All rights reserved.
//

import UIKit

public extension UIImage {
    
    /// color 转 image
    static func image(with color: UIColor) -> UIImage? {
        return self.image(with: color, size: CGSize(width: 1, height: 1))
    }
    
    /// color 转 image
    static func image(with color: UIColor, size: CGSize) -> UIImage? {
        UIGraphicsBeginImageContextWithOptions(size, false, UIScreen.main.scale)
        guard let context = UIGraphicsGetCurrentContext() else {
            UIGraphicsEndImageContext()
            return nil
        }
        context.setFillColor(color.cgColor)
        context.fill(CGRect(origin: CGPoint.zero, size: size))
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image
    }
    
    /// Creates and returns a image object that has the same image space and component values as the receiver, but has the specified alpha component.
    /// - parameter alpha: The opacity value of the new color object, specified as a value from 0.0 to 1.0. Alpha values below 0.0 are interpreted as 0.0, and values above 1.0 are interpreted as 1.0
    func withAlphaComponent(_ alpha: CGFloat) -> UIImage? {
        UIGraphicsBeginImageContextWithOptions(self.size, false, UIScreen.main.scale)
        guard let context = UIGraphicsGetCurrentContext(), let cgImage = self.cgImage else {
            UIGraphicsEndImageContext()
            return nil
        }
        let area = CGRect(x: 0, y: 0, width: self.size.width, height: self.size.height)
        context.scaleBy(x: 1, y: -1)
        context.translateBy(x: 0, y: -area.size.height)
        context.setBlendMode(CGBlendMode.multiply)
        context.setAlpha(alpha)
        context.draw(cgImage, in: area)
        let newImage = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext()
        return newImage
    }
    
}