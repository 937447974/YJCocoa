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
    
    /// Downsampling large images for display at smaller size
    static func downsample(imageAt imageURL: URL, to pointSize: CGSize, scale: CGFloat = UIScreen.main.scale) -> UIImage? {
        let imageSourceOptions = [kCGImageSourceShouldCache: false] as CFDictionary
        let imageSource = CGImageSourceCreateWithURL(imageURL as CFURL, imageSourceOptions)!
        let maxDimensionInPixels = max(pointSize.width, pointSize.height) * scale
        let downsampleOptions = [kCGImageSourceCreateThumbnailFromImageAlways: true,
                                 kCGImageSourceShouldCacheImmediately: true,
                                 kCGImageSourceCreateThumbnailWithTransform: true,
                                 kCGImageSourceThumbnailMaxPixelSize: maxDimensionInPixels] as CFDictionary
        guard let downsampledImage = CGImageSourceCreateThumbnailAtIndex(imageSource, 0, downsampleOptions) else {
            return nil
        }
        return UIImage(cgImage: downsampledImage)
    }
    
    /// color 转 image
    static func image(with color: UIColor, size: CGSize = CGSize(width: 1, height: 1)) -> UIImage? {
        UIGraphicsBeginImageContextWithOptions(size, false, 0)
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
    
    /// UIView 转 UIImage
    static func image(with view: UIView) -> UIImage? {
        UIGraphicsBeginImageContextWithOptions(view.frameSize, false, 0)
        guard let context = UIGraphicsGetCurrentContext() else {
            return nil
        }
        view.layer.render(in: context)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return newImage
    }
    
    /// UIView 中指定位置取圆角
    /// - parameter view: 视图
    /// - parameter rect: 矩形框
    /// - parameter corner: 是否圆角
    static func image(with view: UIView, rect: CGRect, corner: Bool = false) -> UIImage? {
        UIGraphicsBeginImageContextWithOptions(view.frameSize, false, 0)
        guard let context = UIGraphicsGetCurrentContext() else {
            return nil
        }
        if corner {
            context.addEllipse(in: rect)
        } else {
            let pathRef = CGMutablePath()
            pathRef.addLine(to: CGPoint(x: rect.minX, y: rect.minY))
            pathRef.addLine(to: CGPoint(x: rect.maxX, y: rect.minY))
            pathRef.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY))
            pathRef.addLine(to: CGPoint(x: rect.minX, y: rect.maxY))
            context.addPath(pathRef)
        }
        context.clip()
        view.draw(view.bounds)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return newImage
    }
    
    /// 生成圆角图片
    func withCornerRadius(_ cornerRadius: Float, backgroundColor: UIColor = UIColor.white) -> UIImage? {
        guard cornerRadius > 0 else {
            return self
        }
        let rect = CGRect(origin: CGPoint(), size: self.size)
        UIGraphicsBeginImageContextWithOptions(rect.size, true, 0)
        backgroundColor.setFill()
        UIRectFill(rect)
        let path = UIBezierPath(roundedRect: rect, cornerRadius: CGFloat(cornerRadius))
        path.addClip()
        path.stroke()
        self.draw(in: rect)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return newImage
    }
    
    /// Creates and returns a image object that has the same image space and component values as the receiver, but has the specified alpha component.
    /// - parameter alpha: The opacity value of the new color object, specified as a value from 0.0 to 1.0. Alpha values below 0.0 are interpreted as 0.0, and values above 1.0 are interpreted as 1.0
    func withAlphaComponent(_ alpha: CGFloat) -> UIImage? {
        guard alpha < 1 else {
            return self
        }
        UIGraphicsBeginImageContextWithOptions(self.size, false, 0)
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
    
    /// 图片压缩
    func compress(size: CGSize) -> UIImage? {
        UIGraphicsBeginImageContext(size)
        self.draw(in: CGRect(origin: CGPoint(), size: size))
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return newImage
    }
    
}
