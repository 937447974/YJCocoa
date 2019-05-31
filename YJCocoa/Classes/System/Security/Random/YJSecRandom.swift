//
//  YJSecRandom.swift
//  Pods
//
//  Created by 阳君 on 2019/5/31.
//

import Security

private func randomUL(_ count: Int, format: String?) -> String {
    var bytes = [Int8](repeating: 0, count: count/2)
    let status = SecRandomCopyBytes(kSecRandomDefault, bytes.count, &bytes)
    var result = ""
    if status == errSecSuccess {
        for byte in bytes {
            if format == nil {
                if arc4random() % 2 == 0 {
                    result += String(format: "%02X", abs(byte))
                } else {
                    result += String(format: "%02x", abs(byte))
                }
            } else {
                result += String(format: format!, abs(byte))
            }
        }
    }
    return result
}

/// 生成指定位数的随机密码（字母全大写）
public func YJSecRandomU(count: Int) -> String {
    return randomUL(count, format: "%02X")
}

/// 生成指定位数的随机密码（字母全小写）
public func YJSecRandomL(count: Int) -> String {
    return randomUL(count, format: "%02x")
}

/// 生成指定位数的随机密码（字母大写或小写，耗时)
public func YJSecRandomUL(count: Int) -> String {
    return randomUL(count, format: nil)
}
