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
import CoreImage

public extension UIImage {
    
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
    
    /// 渐变色转 image
    static func image(with gradientColors: [CGColor], opaque: Bool, start startPoint: CGPoint, end endPoint: CGPoint) -> UIImage? {
        let size = CGSize(width: max(startPoint.x, endPoint.x), height:  max(startPoint.y, endPoint.y))
        UIGraphicsBeginImageContextWithOptions(size, false, 0)
        let colorSpace = CGColorSpaceCreateDeviceRGB()
        let colors = gradientColors as CFArray
        guard let context = UIGraphicsGetCurrentContext(),
            let gradient = CGGradient(colorsSpace: colorSpace, colors: colors, locations: nil) else {
                UIGraphicsEndImageContext()
                return nil
        }
        if opaque {
            context.setFillColor(UIColor.white.cgColor)
            context.fill(CGRect(origin: CGPoint.zero, size: size))
        }
        context.drawLinearGradient(gradient, start: startPoint, end: endPoint, options: CGGradientDrawingOptions(rawValue: 0))
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image
    }
    
    /// UIView 转 UIImage
    static func image(with view: UIView) -> UIImage? {
        UIGraphicsBeginImageContextWithOptions(view.frameSize, false, 0)
        guard let context = UIGraphicsGetCurrentContext() else {
            UIGraphicsEndImageContext()
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
        UIGraphicsBeginImageContextWithOptions(view.frameSize, true, 0)
        guard let context = UIGraphicsGetCurrentContext() else {
            UIGraphicsEndImageContext()
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
    
    /// 生成二维码
    static func imageQRCode(with url: String, to width: CGFloat) -> UIImage? {
        guard let filter = CIFilter(name: "CIQRCodeGenerator"), let data = url.data(using: .utf8) else { return nil }
        filter.setDefaults()
        filter.setValue(data, forKey: "inputMessage")
        guard let ciImage = filter.outputImage else { return nil }
        // 生成高清的UIImage
        let extent = ciImage.extent.integral
        let scale = min(width/extent.width, width/extent.height)
        let width = Int(extent.width * scale)
        let height = Int(extent.height * scale)
        let cs = CGColorSpaceCreateDeviceGray()
        guard let bitmapRef = CGContext(data: nil, width: width, height: height, bitsPerComponent: 8, bytesPerRow: 0, space: cs, bitmapInfo: 0) else { return nil }
        let context = CIContext(options: nil)
        guard let bitmapImage = context.createCGImage(ciImage, from: extent) else { return nil }
        bitmapRef.interpolationQuality = CGInterpolationQuality.none
        bitmapRef.scaleBy(x: scale, y: scale)
        bitmapRef.draw(bitmapImage, in: extent)
        guard let cgImage = bitmapRef.makeImage() else { return nil }
        return UIImage(cgImage: cgImage)
    }
    
    /// 本地图片预解码加载 Downsampling large images for display at smaller size
    static func downsample(imageAt imageURL: URL, to pointSize: CGSize) -> UIImage? {
        let imageSourceOptions = [kCGImageSourceShouldCache: false] as CFDictionary
        guard let imageSource = CGImageSourceCreateWithURL(imageURL as CFURL, imageSourceOptions) else { return nil }
        var maxPixelSize = max(pointSize.width, pointSize.height) * UIScreen.main.scale
        if maxPixelSize <= 0 { maxPixelSize = UIScreen.main.bounds.height }
        let downsampleOptions = [kCGImageSourceCreateThumbnailFromImageAlways: true,
                                 kCGImageSourceShouldCacheImmediately: true,
                                 kCGImageSourceCreateThumbnailWithTransform: true,
                                 kCGImageSourceThumbnailMaxPixelSize: maxPixelSize] as CFDictionary
        guard let downsampledImage = CGImageSourceCreateThumbnailAtIndex(imageSource, 0, downsampleOptions) else {
            return nil
        }
        return UIImage(cgImage: downsampledImage).decodedImage
    }
    
    /// 图片解码
    var decodedImage: UIImage {
        // Decoding only works for CG-based image.
        guard let imageRef = self.cgImage else { return self }
        let size = CGSize(width: CGFloat(imageRef.width) / self.scale, height: CGFloat(imageRef.height) / self.scale)
        UIGraphicsBeginImageContextWithOptions(size, false, scale)
        guard let context = UIGraphicsGetCurrentContext() else { return self }
        defer { UIGraphicsEndImageContext() }
        // If drawing a CGImage, we need to make context flipped.
        context.scaleBy(x: 1.0, y: -1.0)
        context.translateBy(x: 0, y: -size.height)
        context.draw(imageRef, in: CGRect(origin: .zero, size: size))
        guard let cgImage = context.makeImage() else { return self }
        return UIImage(cgImage: cgImage, scale: self.scale, orientation: self.imageOrientation)
    }
    
    /// 生成圆角图片
    func withCornerRadius(_ cornerRadius: CGFloat, size: CGSize, backgroundColor: UIColor = UIColor.white) -> UIImage? {
        guard cornerRadius > 0 else {
            return self
        }
        let rect = CGRect(origin: CGPoint(), size: size)
        UIGraphicsBeginImageContextWithOptions(size, true, 0)
        backgroundColor.setFill()
        UIRectFill(rect)
        let path = UIBezierPath(roundedRect: rect, cornerRadius: cornerRadius)
        path.addClip()
        path.stroke()
        self.draw(in: rect)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return newImage
    }
    
    /// 图片换色
    func withTintColor(color: UIColor) -> UIImage? {
        if #available(iOS 13.0, *) {
            return self.withTintColor(color)
        }
        UIGraphicsBeginImageContextWithOptions(self.size, false, 0)
        color.setFill()
        let rect = CGRect(origin: CGPoint(), size: self.size)
        UIRectFill(rect)
        self.draw(in: rect, blendMode: .overlay, alpha: 1)
        self.draw(in: rect, blendMode: .destinationIn, alpha: 1)
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
        let area = CGRect(origin: CGPoint(), size: self.size)
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
        UIGraphicsBeginImageContextWithOptions(size, false, 0)
        self.draw(in: CGRect(origin: CGPoint(), size: size))
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return newImage
    }
    
}
