//
//  YJLeaksViewController.swift
//  YJLeaks
//
//  Created by 阳君 on 2019/6/17.
//  Copyright © 2019 YJCocoa. All rights reserved.
//

import UIKit
import YJCocoa
import HandyJSON

var obj: Any?

class YJLeaksViewController: UIViewController & HandyJSON  {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.green
//        self.leakVC()
        self.leakView()
//        self.leakProperty()
        YJLeaks.shared.captureMemoryLeaks(target: self)
        
//        JSONDeserializer<YJLeaksViewController>.deserializeFrom(dict: ["1":"1"])
//        print(YJJSONModel.transformToDict(self))
        
   
    }
    
    func leakVC() {
        obj = self
    }
    
    func leakView() {
        let view = YJLeaksView(frame: CGRect(x: 100, y: 100, width: 100, height: 100))
        view.backgroundColor = UIColor.white
        self.view.addSubview(view)
        obj = view
    }
    
    func leakProperty() {
        
    }
    
    
    
    
}
