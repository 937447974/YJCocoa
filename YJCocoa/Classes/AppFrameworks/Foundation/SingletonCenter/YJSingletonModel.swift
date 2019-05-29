//
//  YJSingletonModel.swift
//  Pods
//
//  Created by 阳君 on 2019/5/22.
//

import UIKit

internal class YJSingletonModel {
    
    private let mutex = YJPthreadMutex()
    var obj: AnyObject!
    
    func object(aClass: AnyClass, forIdentifier identifier: String) -> AnyObject {
        guard self.obj != nil else {
            return self.mutex.lockObj {[unowned self] () -> AnyObject in
                if self.obj != nil {
                    return self.obj
                } else if let viewType = aClass as? UIView.Type {
                    self.obj = viewType.init(frame: CGRect.zero)
                } else if let objType = aClass as? NSObject.Type  {
                    self.obj = objType.init()
                }
                return self.obj
            }
        }
        return self.obj
    }
    
}
