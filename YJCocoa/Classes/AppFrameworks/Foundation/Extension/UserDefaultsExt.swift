//
//  UserDefaultsExt.swift
//  Pods
//
//  Created by 阳君 on 2020/5/21.
//

import UIKit

/// UserDefaults 扩展
public extension UserDefaults {
    
    func setSafe(_ value: String?, forKey defaultName: String) {
        if let str = value {
            self.set(value, forKey: defaultName)
            try? str.write(to: self.safeURL(forKey: defaultName), atomically: true, encoding: .utf8)
        } else {
            self.removeSafeObject(forKey: defaultName)
        }
    }
    
    func removeSafeObject(forKey defaultName: String) {
        self.removeObject(forKey: defaultName)
        try? FileManager.default.removeItem(at: self.safeURL(forKey: defaultName))
    }
    
    func stringSafe(forKey defaultName: String) -> String? {
        if let result = self.string(forKey: defaultName) {
            return result
        }
        let url = self.safeURL(forKey: defaultName)
        if let result = try? String(contentsOf: url, encoding: .utf8) {
            return result
        }
        return nil
    }
    
    private func safeURL(forKey defaultName: String) -> URL {
        let documentPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!
        let documentURL = URL(fileURLWithPath: documentPath)
        return documentURL.appendingDirectory("UserDefaults").appendingPathComponent(defaultName)
    }
    
}

