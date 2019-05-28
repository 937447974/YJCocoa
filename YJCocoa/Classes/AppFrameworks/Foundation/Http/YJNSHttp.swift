//
//  YJNSHttp.swift
//  YJCocoa
//
//  Created by 阳君 on 2019/5/28.
//

import UIKit

/// URLEncode编码
public func YJNSURLEncode(_ str: String) -> String? {
    let characters = CharacterSet(charactersIn: ":/?#[]@!$ &'()*+,;=\"<>%{}|\\^~`").inverted
    return str.addingPercentEncoding(withAllowedCharacters: characters)
}

/// URLEncode解码
public func YJNSURLDecode(_ str: String) -> String? {
    return str.removingPercentEncoding
}

/// http 参数解析与组装
public class YJNSHttp: NSObject {
    
    /**
     * http组装
     * - Parameter http: 链接
     * - Parameter params: 参数
     * - Parameter encode: 是否 encode 编码参数
     */
    class func assemblyParams(_ http: String?, params: Dictionary<String, Any>, encode: Bool) -> String {
        var result = ""
        for (key, var value) in params {
            if value is String {
                if encode {
                    value = YJNSURLEncode(value as! String) ?? ""
                }
            }
            result += "&\(key)=\(value)"
        }
        if result.count != 0 {
            let range = 
            result = result.substring(with: Range(1..<result.count))
        }
        
        if http == nil {
            
        } else {
            if result.count == 0 {
                result = http
            }
            result = http! + (http!.contains("?") ? "": "?") + result
        }
        return result
    }
    
    /**
     * http参数解析
     * - Parameter http: 链接
     * - Parameter params: 参数
     * - Parameter encode: 是否 encode 编码参数
     */
    class func analysisParams(_ http: String, decode: Bool) -> Dictionary<String, Any> {
        var params: String = http.components(separatedBy: "?").last!
        params = params.components(separatedBy: "#")[0]
        var result = Dictionary<String, Any>()
        for item in params.components(separatedBy: "&") {
            let keyValue = item.components(separatedBy: "=")
            let key = keyValue[0]
            let value = keyValue.count == 2 ? keyValue[1] : ""
            result[key] = decode ? YJNSURLDecode(value) ?? "" : ""
        }
        return result
    }
    
}
