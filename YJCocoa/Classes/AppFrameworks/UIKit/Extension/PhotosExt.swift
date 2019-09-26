//
//  PhotosExt.swift
//  Pods
//
//  Created by 阳君 on 2019/9/26.
//

import UIKit
import Photos

/// PHPhotoLibrary.shared()
public let PHPhotoLibraryS = PHPhotoLibrary.shared()
/// PHImageManager.default()
public let PHImageManagerS = PHImageManager.default()

public typealias PHCompletionHandler = (Bool, Error?) -> Void

/// PHAssetCollection扩展
public extension PHAssetCollection {
    
    /// 获取PHAsset集合
    ///
    /// - parameter options : PHFetchOptions?
    ///
    /// - returns: [PHAsset]
    func fetchAssetsWithOptions(_ options: PHFetchOptions? = nil) -> [PHAsset] {
        var assets = [PHAsset]()
        let fetchResult = PHAsset.fetchAssets(in: self, options: options)
        fetchResult.enumerateObjects { (asset, _, _) in
            assets.append(asset)
        }
        return assets
    }
    
    /// 存储照片
    ///
    /// - parameter image: 图片
    ///
    /// - returns: void
    func creationAssetFromImage(_ image: UIImage, completionHandler: PHCompletionHandler? = nil) {
        PHPhotoLibraryS.performChanges({
            let assetChangeRequest = PHAssetChangeRequest.creationRequestForAsset(from: image)
            guard let placeholderForCreatedAsset = assetChangeRequest.placeholderForCreatedAsset,
                let aCChangeRequest = PHAssetCollectionChangeRequest(for: self) else {
                    completionHandler?(false, nil)
                    YJLogError("[PHAssetCollection] 照片生成出错")
                    return
            }
            aCChangeRequest.addAssets([placeholderForCreatedAsset] as NSFastEnumeration)
        }, completionHandler: completionHandler)
    }
    
    /// 创建相薄
    ///
    /// - parameter title: 相薄名
    class func creationWithTitle(_ title: String, completionHandler: PHCompletionHandler? = nil) {
        PHPhotoLibrary.shared().performChanges({
            PHAssetCollectionChangeRequest.creationRequestForAssetCollection(withTitle: title)
        }, completionHandler: completionHandler)
    }
    
    /// 修改相薄名
    ///
    /// - parameter title: 相薄名
    func updateTitle(_ title: String, completionHandler: PHCompletionHandler? = nil) {
        PHPhotoLibraryS.performChanges({
            let aCChangeRequest = PHAssetCollectionChangeRequest(for: self)
            aCChangeRequest?.title = title
        }, completionHandler: completionHandler)
    }
    
    /// 删除专辑
    func deletes(_ completionHandler: PHCompletionHandler? = nil) {
        PHPhotoLibraryS.performChanges({
            PHAssetCollectionChangeRequest.deleteAssetCollections([self] as NSFastEnumeration)
        }, completionHandler: completionHandler)
    }
    
}

public extension PHCollectionList {
    
    /// 获取PHAsset集合
    ///
    /// - parameter options : PHFetchOptions?
    ///
    /// - returns: [PHAsset]
    func fetchAssetsWithOptions(_ options: PHFetchOptions? = nil) -> [PHAsset] {
        var assets = [PHAsset]()
        let fetchResult = PHAssetCollection.fetchMoments(inMomentList: self, options: options)
        fetchResult.enumerateObjects { (assetCollection, _, _) in
            assets.append(contentsOf: assetCollection.fetchAssetsWithOptions(options))
        }
        return assets
    }
    
}

/// PHAsset扩展
public extension PHAsset {
    
    /// 删除图片
    ///
    /// - parameter assetCollection: PHAssetCollection
    /// - parameter assetCollection: 执行回调
    func delete(with assetCollection: PHAssetCollection? = nil, completionHandler: PHCompletionHandler? = nil) {
        PHPhotoLibraryS.performChanges({
            let assets = [self] as NSFastEnumeration
            if let assetCollection = assetCollection {
                PHAssetCollectionChangeRequest(for: assetCollection)?.removeAssets(assets)
            } else {
                PHAssetChangeRequest.deleteAssets(assets)
            }
        }, completionHandler: completionHandler)
    }
    
    /// 收藏图片
    ///
    /// - parameter favorite: 是否收藏
    /// - parameter completionHandler: 执行完毕回调
    func setFavorite(_ favorite: Bool, completionHandler: PHCompletionHandler? = nil) {
        PHPhotoLibraryS.performChanges({
            let request = PHAssetChangeRequest(for: self)
            request.isFavorite = favorite
        }, completionHandler: completionHandler)
    }
    
}

let ImageAssetCache = NSCache<NSString, UIImage>()
let AssetIdentifier = UnsafeRawPointer.init(bitPattern: "yj_assetIdentifier".hashValue)!

/// UIImageView+PHAsset
public extension UIImageView {
    
    private var assetIdentifier: NSString {
        get { return objc_getAssociatedObject(self, AssetIdentifier) as! NSString }
        set { objc_setAssociatedObject(self, AssetIdentifier, newValue, .OBJC_ASSOCIATION_COPY_NONATOMIC) }
    }
    
    func setImage(_ asset: PHAsset, placeholder: UIImage? = nil, progressHandler: PHAssetImageProgressHandler? = nil) {
        let size = CGSize(width: self.frameWidth * UIScreen.main.scale, height: self.frameHeight * UIScreen.main.scale)
        let key = asset.localIdentifier + "\(size)" as NSString
        self.assetIdentifier = key
        if let image = ImageAssetCache.object(forKey: key) {
            self.image = image
            return
        } else {
            self.image = placeholder
        }
        let options = PHImageRequestOptions()
        options.isNetworkAccessAllowed = true
        options.progressHandler = progressHandler
        PHImageManagerS.requestImage(for: asset, targetSize: size, contentMode: .aspectFill, options: options) { [weak self] (image, _) in
            guard let image = image else { return }
            ImageAssetCache.setObject(image, forKey: key)
            guard let assetIdentifier = self?.assetIdentifier, assetIdentifier == key else { return }
            self?.image = image
        }
    }
    
}
