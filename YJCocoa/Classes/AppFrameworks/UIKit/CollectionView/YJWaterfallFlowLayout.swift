//
//  YJWaterfallFlowLayout.swift
//  YJCocoa
//
//  HomePage:https://github.com/937447974/YJCocoa
//  YJ技术支持群:557445088
//
//  Created by 阳君 on 2020/5/24.
//  Copyright © 2016-现在 YJCocoa. All rights reserved.
//

import UIKit

/// CollectionView 瀑布流
open class YJWaterfallFlowLayout: UICollectionViewFlowLayout {
    
    // 总列数
    public var columnCount: Int = 0
    private var maxHeight: CGFloat = 0
    private var layoutAttributes = [UICollectionViewLayoutAttributes]()
    private var headerLayoutAttributes = [UICollectionViewLayoutAttributes]()
    private var cellLayoutAttributes = [[UICollectionViewLayoutAttributes]]()
    
    open override var collectionViewContentSize: CGSize {
        get {
            return CGSize(width: (collectionView?.bounds.width)!, height: self.maxHeight)
        }
    }
    
    open override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        return self.layoutAttributes
    }
    
    open override func prepare() {
        self.maxHeight = 0
        self.layoutAttributes.removeAll()
        self.headerLayoutAttributes.removeAll()
        self.cellLayoutAttributes.removeAll()
        guard let collectionView = self.collectionView,
            let delegate = collectionView.delegate as? UICollectionViewDelegateFlowLayout,
            let dataSource = collectionView.dataSource
            else {
                return
        }
        let sectionCount = dataSource.numberOfSections!(in: collectionView)
        for section in 0..<sectionCount {
            // header
            let headerLA = self.prepareHeader(delegate: delegate, section: section, y: self.maxHeight)
            self.headerLayoutAttributes.append(headerLA)
            self.layoutAttributes.append(headerLA)
            self.maxHeight = headerLA.frame.maxY + self.sectionInset.top
            // cell
            let cellLAList = self.prepareCell(delegate: delegate, dataSource: dataSource, section: section, y: self.maxHeight)
            self.cellLayoutAttributes.append(cellLAList)
            self.layoutAttributes.append(contentsOf: cellLAList)
            cellLAList.forEach { (la) in
                self.maxHeight = max(self.maxHeight, la.frame.maxY)
            }
            // bottom
            self.maxHeight = self.maxHeight + self.sectionInset.bottom
        }
    }
    
    func prepareHeader(delegate: UICollectionViewDelegateFlowLayout, section: Int, y: CGFloat) -> UICollectionViewLayoutAttributes {
        let headerSize = self.sizeForHeader(delegate: delegate, section: section)
        let result = UICollectionViewLayoutAttributes(forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, with: IndexPath(item: 0, section: section))
        result.frame = CGRect(origin: CGPoint(x: 0, y: y), size: headerSize)
        return result
    }
    
    func sizeForHeader(delegate: UICollectionViewDelegateFlowLayout, section: Int) -> CGSize {
        if let headerSize = delegate.collectionView?(self.collectionView!, layout: self, referenceSizeForHeaderInSection: section) {
            return headerSize
        }
        return self.headerReferenceSize
    }
    
    func prepareCell(delegate: UICollectionViewDelegateFlowLayout ,dataSource: UICollectionViewDataSource, section: Int, y: CGFloat) -> [UICollectionViewLayoutAttributes] {
        var result = [UICollectionViewLayoutAttributes]()
        let columnXList = self.prepareColumnXList()
        var columnYList = [CGFloat](repeating: y - self.minimumLineSpacing, count: self.columnCount)
        var columnIndex = 0
        var highLowIndex = (0, 0)
        let itemCount = dataSource.collectionView(self.collectionView!, numberOfItemsInSection: section)
        for item in 0..<itemCount {
            let indexPath = IndexPath(item: item, section: section)
            let layoutAttributes = UICollectionViewLayoutAttributes(forCellWith: indexPath)
            result.append(layoutAttributes)
            // size
            let itemSize = self.sizeForItem(delegate: delegate, indexPath: indexPath)
            layoutAttributes.size = itemSize
            // origin
            let highIndex = highLowIndex.0, lowIndex = highLowIndex.1
            if itemSize.height <= columnYList[highIndex] - columnYList[lowIndex] {// 跳跃插入
                layoutAttributes.frame.origin = CGPoint(x: columnXList[lowIndex], y: columnYList[lowIndex] + self.minimumLineSpacing)
                columnYList[lowIndex] = layoutAttributes.frame.maxY
                highLowIndex = self.prepareHighLowIndex(columnYList: columnYList)
            } else {
                layoutAttributes.frame.origin = CGPoint(x: columnXList[columnIndex], y: columnYList[columnIndex] + self.minimumLineSpacing)
                columnYList[columnIndex] = layoutAttributes.frame.maxY
                columnIndex = columnIndex + 1
                if columnIndex == self.columnCount - 1 { // 换行
                    highLowIndex = self.prepareHighLowIndex(columnYList: columnYList)
                    columnIndex = 0
                }
            }
        }
        return result
    }
    
    func prepareColumnXList() -> [CGFloat] {
        let contentWidth = self.collectionView!.boundsWidth - self.sectionInset.left - self.sectionInset.right
        let itemWidth = (contentWidth - self.minimumInteritemSpacing * CGFloat(self.columnCount - 1)) / CGFloat(self.columnCount)
        var columnXArray = [CGFloat]()
        var x = self.sectionInset.left
        for _ in 0..<self.columnCount {
            columnXArray.append(x)
            x = x + itemWidth + self.minimumInteritemSpacing
        }
        return columnXArray
    }
    
    func prepareHighLowIndex(columnYList: [CGFloat]) -> (Int, Int) {
        var result = (0, 0)
        var height = columnYList[0], low = columnYList[0]
        for i in 1..<columnYList.count {
            if columnYList[i] > height {
                result.0 = i
                height = columnYList[i]
            } else if columnYList[i] < low {
                result.1 = i
                low = columnYList[i]
            }
        }
        return result
    }
    
    func sizeForItem(delegate: UICollectionViewDelegateFlowLayout, indexPath: IndexPath) -> CGSize {
        if let itemSize = delegate.collectionView?(self.collectionView!, layout: self, sizeForItemAt: indexPath) {
            return itemSize
        }
        return self.itemSize
    }
    
}
