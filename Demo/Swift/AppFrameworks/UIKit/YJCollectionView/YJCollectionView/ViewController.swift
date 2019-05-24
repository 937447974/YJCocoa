//
//  ViewController.swift
//  YJCollectionView
//
//  Created by 阳君 on 2019/5/23.
//  Copyright © 2019 YJCocoa. All rights reserved.
//

import UIKit
import YJCocoa

class ViewController: UIViewController {
    
    lazy var collectionView: YJUICollectionView = {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.sectionInset = UIEdgeInsets(top: 15, left: 15, bottom: 15, right: 15)
        flowLayout.minimumLineSpacing = 10;
        flowLayout.minimumInteritemSpacing = 10;
        flowLayout.headerReferenceSize = CGSize(width: 10, height: 100)
        flowLayout.footerReferenceSize = CGSize(width: 10, height: 100)
        let collectionView = YJUICollectionView(frame: self.view.bounds, collectionViewLayout: flowLayout)
        collectionView.backgroundColor = UIColor.white
        collectionView.alwaysBounceVertical = true
        collectionView.dataSource = self
        collectionView.delegate = self
        return collectionView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addSubview(self.collectionView)
        self.testData()
    }
    
    func testData() {
        // cell
        for i in 0..<30 {
            let cm = YJTestCVCellModel(text: "\(i)")
            let co = YJTestCVCell.cellObject(withCellModel: cm)
            co.didSelectBlock = {(_, _) in
                print("点击 \(i)")
            }
            self.collectionView.dataSourceCellFirst.append(co)
        }
        // 头部、尾部
        self.collectionView.dataSourceHeader.append(YJTestCRView.cellObject(withCellModel: UIColor.red))
        self.collectionView.dataSourceFooter.append(YJTestCRView.cellObject(withCellModel: UIColor.yellow))
        self.collectionView.reloadData()
    }
    
}

extension ViewController: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return self.collectionView.manamger.numberOfSections(in: collectionView)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.collectionView.manamger.collectionView(collectionView, numberOfItemsInSection: section)
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        return self.collectionView.manamger.collectionView(collectionView, cellForItemAt: indexPath)
    }
    
    public func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        return self.collectionView.manamger.collectionView(collectionView, viewForSupplementaryElementOfKind:kind, at: indexPath)
    }
    
}

extension ViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.collectionView.manamger.collectionView(collectionView, didSelectItemAt: indexPath)
    }
    
}

extension ViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return self.collectionView.manamger.collectionView(collectionView, layout: collectionViewLayout, sizeForItemAt: indexPath)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return self.collectionView.manamger.collectionView(collectionView, layout: collectionViewLayout, referenceSizeForHeaderInSection: section)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        return self.collectionView.manamger.collectionView(collectionView, layout: collectionViewLayout, referenceSizeForFooterInSection: section)
    }
    
}
