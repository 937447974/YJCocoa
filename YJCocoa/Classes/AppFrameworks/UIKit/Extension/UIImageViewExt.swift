//
//  UIImageViewExt.swift
//  YJCocoa
//
//  HomePage:https://github.com/937447974/YJCocoa
//  YJ技术支持群:557445088
//
//  Created by 阳君 on 2019/9/27.
//  Copyright © 2016-现在 YJCocoa. All rights reserved.
//

import UIKit
import Photos

let ImageAssetCache = NSCache<NSString, UIImage>()
let AssetIdentifier = UnsafeRawPointer.init(bitPattern: "yj_assetIdentifier".hashValue)!

/// UIImageView+PHAsset
public extension UIImageView {
    
    private var assetIdentifier: NSString {
        get { return objc_getAssociatedObject(self, AssetIdentifier) as! NSString }
        set { objc_setAssociatedObject(self, AssetIdentifier, newValue, .OBJC_ASSOCIATION_COPY_NONATOMIC) }
    }
    
    /// 清空 PHAsset 图片缓存
    static func removeCachingImagesForAllAssets() {
        ImageAssetCache.removeAllObjects()
    }
    
    /// 设置 PHAsset 图片
    func setImage(_ asset: PHAsset, placeholder: UIImage? = nil, progressHandler: PHAssetImageProgressHandler? = nil) {
        self.contentMode = .scaleAspectFill
        let scale = UIScreen.main.scale
        let size = CGSize(width: self.frameWidth * scale, height: self.frameHeight * scale)
        let key = asset.localIdentifier + "\(size)" as NSString
        self.assetIdentifier = key
        if let image = ImageAssetCache.object(forKey: key) {
            self.setAssetImage(image, identifier: key)
            return
        } else {
            self.image = placeholder
        }
        let options = PHImageRequestOptions()
        options.isNetworkAccessAllowed = true
        options.progressHandler = progressHandler
        options.resizeMode = .fast
        PHImageManagerS.requestImage(for: asset, targetSize: size, contentMode: .aspectFill, options: options) { [weak self] (image, _) in
            guard let image = image else { return }
            ImageAssetCache.setObject(image, forKey: key)
            guard let assetIdentifier = self?.assetIdentifier, assetIdentifier == key else { return }
            dispatch_async_main { [weak self] in
                self?.setAssetImage(image, identifier: key)
            }
        }
    }
    
    private func setAssetImage(_ image: UIImage, identifier: NSString) {
        guard self.assetIdentifier == identifier else { return }
        let flexibleHeight = image.size.width <= image.size.height
        self.autoresizingMask = flexibleHeight ? .flexibleHeight : .flexibleWidth
        self.image = image
    }
    
}
