//
//  ViewController.swift
//  YJScroolView
//
//  Created by 阳君 on 2019/5/23.
//  Copyright © 2019 YJCocoa. All rights reserved.
//

import UIKit
import YJCocoa

class ViewController: UIViewController {
    
    lazy var scrollView: UIScrollView = {
        let sc = UIScrollView(frame: self.view.bounds)
        sc.contentSize = CGSize(width: 1000, height: 1500)
        sc.delegate = self
        let view = UIView(frame: CGRect(x: 100, y: 100, width: 100, height: 100))
        view.backgroundColor = UIColor.red
        sc.addSubview(view)
        return sc
    }()
    
    var svManager = YJUIScroolViewManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addSubview(self.scrollView)
        
        self.svManager.edgeInset = UIEdgeInsets(top: 50, left: 50, bottom: 50, right: 50)// 正边缘
        self.svManager.endInset =  UIEdgeInsets(top: -20, left: -20, bottom: -20, right: -20)// 负边界
        self.svManager.didVerticalScrollBlock = {(scroll: YJUIScrollViewScroll) in
            print("Vertical \(scroll)")
        }
        self.svManager.didHorizontalScrollBlock = {(scroll: YJUIScrollViewScroll) in
            print("  Horizontal \(scroll)")
        }
    }
    
}

extension ViewController: UIScrollViewDelegate {
    
    public func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        self.svManager.scrollViewWillBeginDragging(scrollView)
    }
    
    public func scrollViewDidScroll(_ scrollView: UIScrollView) {
        self.svManager.scrollViewDidScroll(scrollView)
    }
    
}

