//
//  UIApplicationExt.swift
//  YJCocoa
//
//  HomePage:https://github.com/937447974/YJCocoa
//  YJ技术支持群:557445088
//
//  Created by 阳君 on 2019/9/24.
//  Copyright © 2019 YJCocoa. All rights reserved.
//

import UIKit

/// UIApplication 扩展
public extension UIApplication {
    
    /// Attempts to open the resource at the specified URL asynchronously.
    func open(_ url: String, options: [UIApplication.OpenExternalURLOptionsKey : Any] = [:], completionHandler completion: ((Bool) -> Void)? = nil) {
        let url = URL(string: url)!
        if #available(iOS 10.0, *) {
            self.open(url, options: options, completionHandler: completion)
        } else {
            let result = self.openURL(url)
            completion?(result)
        }
    }
    
}
