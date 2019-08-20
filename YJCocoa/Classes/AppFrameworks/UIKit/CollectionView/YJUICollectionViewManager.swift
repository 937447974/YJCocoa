//
//  YJUICollectionViewManager.swift
//  YJCocoa
//
//  HomePage:https://github.com/937447974/YJCocoa
//  YJ技术支持群:557445088
//
//  Created by 阳君 on 2019/5/23.
//  Copyright © 2016-现在 YJCocoa. All rights reserved.
//

import UIKit

/// 缓存 size 的策略
public enum YJUICollectionViewCacheSize : Int {
    /// 根据相同的UITableViewCell类缓存高度
    case `default`
    /// 根据NSIndexPath对应的位置缓存高度
    case indexPath
    /// 根据类名和NSIndexPath双重绑定缓存高度
    case classAndIndexPath
}

/** UICollectionView管理器*/
@objcMembers
open class YJUICollectionViewManager: NSObject {
    
    /// header 数据源
    public var dataSourceHeader = Array<YJUICollectionCellObject>()
    /// header 数据源
    public var dataSourceFooter = Array<YJUICollectionCellObject>()
    /// cell 数据源
    public var dataSourceCell = Array<Array<YJUICollectionCellObject>>()
    /// cell 第一组数据源
    public var dataSourceCellFirst: Array<YJUICollectionCellObject> {
        get {return self.dataSourceCell.first!}
        set {
            if self.dataSourceCell.count > 0 {
                self.dataSourceCell[0] = newValue
            } else {
                self.dataSourceCell.append(newValue)
            }
        }
    }
    
    /// 是否缓存高，默认缓存
    public var isCacheSize = true
    /// 缓存size的策略
    public var cacheSize = YJUICollectionViewCacheSize.default
    
    public weak private(set) var collectionView: UICollectionView!
    public weak private(set) var flowLayout: UICollectionViewFlowLayout!
    
    private var identifierSet = Set<String>()
    private var cacheSizeDict = Dictionary<String, CGSize>()
    
    public init(collectionView: UICollectionView) {
        super.init()
        self.collectionView = collectionView
        self.flowLayout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout
        self.dataSourceCellFirst = Array()
    }
    
}

extension YJUICollectionViewManager: UICollectionViewDataSource {
    
    public func numberOfSections(in collectionView: UICollectionView) -> Int {
        return self.dataSourceCell.count
    }
    
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard section < self.dataSourceCell.count else {
            YJLogWarn("error:数组越界; selector:\(#function)")
            return 0
        }
        return self.dataSourceCell[section].count
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let co = self.cellObject(with: indexPath) else {
            YJLogWarn("error:数组越界; selector:\(#function)")
            return UICollectionViewCell(frame: CGRect.zero)
        }
        return self.dequeueReusableCell(withCellObject: co)
    }
    
    public func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let isHeader = UICollectionView.elementKindSectionHeader == kind
        guard let co = isHeader ? self.cellHeaderObject(with: indexPath.section) : self.cellFooterObject(with: indexPath.section) else {
            return UICollectionReusableView(frame: CGRect.zero)
        }
        return self.dequeueReusableSupplementaryView(ofKind: kind, for: co)
    }
    
    private func dequeueReusableCell(withCellObject cellObject: YJUICollectionCellObject) -> UICollectionViewCell {
        if !self.identifierSet.contains(cellObject.reuseIdentifier) {
            self.collectionView.register(cellObject.cellClass, forCellWithReuseIdentifier: cellObject.reuseIdentifier)
            self.identifierSet.insert(cellObject.reuseIdentifier)
        }
        let cell = self.collectionView.dequeueReusableCell(withReuseIdentifier: cellObject.reuseIdentifier, for: cellObject.indexPath)
        cell.collectionViewManager(self, reloadWith: cellObject)
        return cell
    }
    
    private func dequeueReusableSupplementaryView(ofKind elementKind: String, for cellObject: YJUICollectionCellObject) -> UICollectionReusableView {
        let identifier = elementKind + cellObject.reuseIdentifier
        if !self.identifierSet.contains(identifier) {
            self.collectionView.register(cellObject.cellClass, forSupplementaryViewOfKind: elementKind, withReuseIdentifier: identifier)
            self.identifierSet.insert(identifier)
        }
        let reusableView = self.collectionView.dequeueReusableSupplementaryView(ofKind: elementKind, withReuseIdentifier: identifier, for: cellObject.indexPath)
        reusableView.collectionViewManager(self, reloadWith: cellObject)
        return reusableView
    }
    
}

extension YJUICollectionViewManager: UICollectionViewDelegate {
    
    public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let co = self.cellObject(with: indexPath) {
            co.didSelectClosure?(self, co)
        }
    }
    
}

extension YJUICollectionViewManager: UICollectionViewDelegateFlowLayout {
    
    /// 清除所有缓存Size
    public func clearAllCacheSize() {
        self.cacheSizeDict.removeAll()
    }
    
    //MARK: UICollectionViewDelegateFlowLayout
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        guard let co = self.cellObject(with: indexPath) else {
            YJLogWarn("error:数组越界; selector:\(#function)")
            return self.flowLayout.itemSize
        }
        return self.collectionView(collectionView, referenceSizeFor: "cell", in: co)
    }
    
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        guard let co = self.cellHeaderObject(with: section) else {
            return self.flowLayout.headerReferenceSize
        }
        return self.collectionView(collectionView, referenceSizeFor: UICollectionView.elementKindSectionHeader, in: co)
    }
    
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        guard let co = self.cellFooterObject(with: section) else {
            return self.flowLayout.footerReferenceSize
        }
        return self.collectionView(collectionView, referenceSizeFor: UICollectionView.elementKindSectionFooter, in: co)
    }
    
    // MARK: private
    private func cellObject(with indexPath: IndexPath) -> YJUICollectionCellObject? {
        guard indexPath.section < self.dataSourceCell.count && indexPath.row < self.dataSourceCell[indexPath.section].count else {
            return nil
        }
        let co = self.dataSourceCell[indexPath.section][indexPath.row]
        co.indexPath = indexPath
        return co
    }
    
    private func cellHeaderObject(with section: Int) -> YJUICollectionCellObject? {
        guard section < self.dataSourceHeader.count else {
            return nil
        }
        let co = self.dataSourceHeader[section]
        co.indexPath = IndexPath(row: 0, section: section)
        return co
    }
    
    private func cellFooterObject(with section: Int) -> YJUICollectionCellObject? {
        guard section < self.dataSourceFooter.count else {
            return nil
        }
        let co = self.dataSourceFooter[section]
        co.indexPath = IndexPath(row: 0, section: section)
        return co
    }
    
    private func collectionView(_ collectionView: UICollectionView, referenceSizeFor kind: String, in cellObject: YJUICollectionCellObject) -> CGSize {
        let key = self.getKeyFromCellObject(cellObject)
        if self.isCacheSize {
            if let size = self.cacheSizeDict[key] {
                return size
            }
        }
        var size = CGSize.zero
        if let cellType = cellObject.cellClass as? UICollectionViewCell.Type {
            size = cellType.collectionViewManager(self, sizeWith: cellObject)
        } else {
            size = cellObject.cellClass.collectionViewManager(self, referenceSizeFor: kind, in: cellObject)
        }
        if self.isCacheSize {
            self.cacheSizeDict[key] = size
        }
        return size
    }
    
    private func getKeyFromCellObject(_ cellObject: YJUICollectionCellObject) -> String {
        let indexPath = cellObject.indexPath!
        switch self.cacheSize {
        case .`default`:
            return cellObject.reuseIdentifier
        case .indexPath:
            return "\(indexPath.section)-\(indexPath.row)"
        case .classAndIndexPath:
            return "\(cellObject.reuseIdentifier)-(\(indexPath.section)-\(indexPath.row))"
        }
    }
    
}
