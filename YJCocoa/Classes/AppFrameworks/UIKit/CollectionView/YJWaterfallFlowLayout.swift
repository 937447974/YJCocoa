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
        self.layoutAttributes.removeAll()
        self.headerLayoutAttributes.removeAll()
        self.cellLayoutAttributes.removeAll()
        guard let collectionView = self.collectionView,
            let delegate = collectionView.delegate as? UICollectionViewDelegateFlowLayout,
            let dataSource = collectionView.dataSource
            else {
                return
        }
        var sectionY: CGFloat = 0
        let sectionCount = dataSource.numberOfSections!(in: collectionView)
        for section in 0..<sectionCount {
            // header
            let headerLA = self.prepareHeader(delegate: delegate, section: section, y: sectionY)
            // cell
            sectionY = headerLA.frame.maxY + self.sectionInset.top
            let cellLAList = self.prepareCell(delegate: delegate, dataSource: dataSource, section: section, y: sectionY)
            self.cellLayoutAttributes.append(cellLAList)
            self.layoutAttributes.append(contentsOf: cellLAList)
            cellLAList.forEach { (la) in
                sectionY = max(sectionY, la.frame.maxY)
            }
            sectionY = sectionY + self.sectionInset.bottom
        }
        self.maxHeight = sectionY
    }
    
    func prepareHeader(delegate: UICollectionViewDelegateFlowLayout, section: Int, y: CGFloat) -> UICollectionViewLayoutAttributes {
        var headerSize = self.headerReferenceSize
        if let size = delegate.collectionView?(self.collectionView!, layout: self, referenceSizeForHeaderInSection: section) {
            headerSize = size
        }
        let result = UICollectionViewLayoutAttributes(forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, with: IndexPath(item: 0, section: section))
        result.frame = CGRect(origin: CGPoint(x: 0, y: y), size: headerSize)
        return result
    }
    
    func prepareCell(delegate: UICollectionViewDelegateFlowLayout ,dataSource: UICollectionViewDataSource, section: Int, y: CGFloat) -> [UICollectionViewLayoutAttributes] {
        var result = [UICollectionViewLayoutAttributes]()
        let columnXList = self.prepareColumnXList()
        var columnMaxYList = [CGFloat](repeating: y - self.minimumLineSpacing, count: self.columnCount)
        var lowIndex = 0, highIndex = 0, columnIndex = 0
        let itemCount = dataSource.collectionView(self.collectionView!, numberOfItemsInSection: section)
        for item in 0..<itemCount {
            let indexPath = IndexPath(item: item, section: section)
            let layoutAttributes = UICollectionViewLayoutAttributes(forCellWith: indexPath)
            result.append(layoutAttributes)
            // size
            let itemSize = self.sizeForItem(delegate: delegate, indexPath: indexPath)
            layoutAttributes.size = itemSize
            // origin
            if itemSize.height <= columnMaxYList[highIndex] - columnMaxYList[lowIndex] {// 跳跃插入
                layoutAttributes.frame.origin = CGPoint(x: columnXList[lowIndex], y: columnMaxYList[lowIndex] + self.minimumLineSpacing)
                columnMaxYList[lowIndex] = layoutAttributes.frame.maxY
                let highLowIndex = self.prepareHighLowIndex(columnMaxYList: columnMaxYList)
                highIndex = highLowIndex.0
                lowIndex = highLowIndex.1
            } else {
                layoutAttributes.frame.origin = CGPoint(x: columnXList[columnIndex], y: columnMaxYList[columnIndex] + self.minimumLineSpacing)
                columnMaxYList[columnIndex] = layoutAttributes.frame.maxY
                columnIndex = columnIndex + 1
                if columnIndex == self.columnCount - 1 { // 换行
                    let highLowIndex = self.prepareHighLowIndex(columnMaxYList: columnMaxYList)
                    highIndex = highLowIndex.0
                    lowIndex = highLowIndex.1
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
    
    func prepareHighLowIndex(columnMaxYList: [CGFloat]) -> (Int, Int) {
        var highIndex = 0, lowIndex = 0
        var height = columnMaxYList[0], low = columnMaxYList[0]
        for i in 1..<columnMaxYList.count {
            if columnMaxYList[i] > height {
                highIndex = i
                height = columnMaxYList[i]
            } else if columnMaxYList[i] < low {
                lowIndex = i
                low = columnMaxYList[i]
            }
        }
        return (highIndex, lowIndex)
    }
    
    func sizeForItem(delegate: UICollectionViewDelegateFlowLayout, indexPath: IndexPath) -> CGSize {
        var itemSize = self.itemSize
        if let size = delegate.collectionView?(self.collectionView!, layout: self, sizeForItemAt: indexPath) {
            itemSize = size
        }
        return itemSize
    }
    
}
