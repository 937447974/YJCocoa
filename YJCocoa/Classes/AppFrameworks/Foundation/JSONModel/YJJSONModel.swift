//
//  YJJSONModel.swift
//  YJCocoa
//
//  HomePage:https://github.com/937447974/YJCocoa
//  YJ技术支持群:557445088
//
//  Created by 阳君 on 2019/6/10.
//  Copyright © 2016-现在 YJCocoa. All rights reserved.
//

import UIKit

/// 基础类型转换协议
public protocol YJJSONModelTransformBasic {
    /// 从 json 转换为模型
    static func transform(fromJSON value: Any) -> Any?
    /// 从模型转换为 json
    static func transform(toJSON value: Any) -> Any?
}

/// stuct & class 转换协议
public protocol YJJSONModelTransformModel: YJJSONModelTransformBasic {
    /// 初始化
    init()
    /// 转换映射器配置
    func transform(mapper: YJJSONModelTransformMapper)
    /// 自定义部分数据转换
    func transform(fromDict dict: Dictionary<String, Any>)
    /// 部分模型数据自定义转换
    func transform(toDict dict: inout Dictionary<String, Any>)
}

/// YJJSONModelTransformModel + default
extension YJJSONModelTransformModel {
    /// 自定义部分数据转换
    public func transform(fromDict dict: Dictionary<String, Any>){}
    /// 部分模型数据自定义转换
    public func transform(toDict dict: inout Dictionary<String, Any>){}
    /// 模型转换为字典
    func transformToDict() -> Dictionary<String, Any> {
        return YJJSONModel<Self>.transformToDict(self)
    }
}

/// YJJSONModelTransformModel + YJJSONModelTransformBasic
extension YJJSONModelTransformModel {
    
    static func transform(fromJSON value: Any) -> Any? {
        if let json = value as? String {
            return YJJSONModel<Self>.transformToModel(Self(), fromJSON: json)
        } else if let dict = value as? Dictionary<String, Any> {
            return YJJSONModel<Self>.transformToModel(Self(), fromDict: dict)
        }
        return nil
    }
    
    static func transform(toJSON value: Any) -> Any? {
        guard let _value = value as? Self else {
            return nil
        }
        return YJJSONModel<Self>.transformToJSON(_value)
    }
    
}

/// 自定义类型转换协议
public protocol YJJSONModelTransformCustom {
    associatedtype Object
    associatedtype JSON
    /// json 转模型
    func transform(fromJSON value: Any) -> Object?
    /// 模型转 json
    func transform(toJSON value: Object) -> JSON?
}

/// 转换映射器
public struct YJJSONModelTransformMapper {
    typealias FromJSONClosure = (Any) -> (Any?)
    typealias ToJSONClosure = (Any) -> (Any?)
    struct Handler {
        var fromJSONClosure: FromJSONClosure
        var toJSONClosure: ToJSONClosure
        init(fromJSONClosure: @escaping FromJSONClosure, toJSONClosure: @escaping ToJSONClosure) {
            self.fromJSONClosure = fromJSONClosure
            self.toJSONClosure = toJSONClosure
        }
    }
    /// 是否区分属性大小写
    var isCaseSensitive = false
    /// 属性对应 JSON 中的 key <属性名, JSON中的key>
    var optionalProperties = [String: String]()
    /// 忽略的属性
    var ignoredProperties = Set<String>()
    /// 需要 kvc 监听的属性
    var kvcProperties = Set<String>()
    /// 自定义转换器的属性 <属性名, YJJSONModelTransformCustom>
    var customProperties = [String: Handler]()
    
    /// 添加属性自定义的模型转换
    mutating func addTransformCustom<Transform: YJJSONModelTransformCustom>(_ property: String, transform: Transform) {
        self.addTransformClosure(property, fromJSONClosure: { (json: Any) -> (Any?) in
            return transform.transform(fromJSON: json)
        }, toJSONClosure: { (value: Any) -> (Any?) in
            guard let obj = value as? Transform.Object else {
                return nil
            }
            return transform.transform(toJSON: obj)
        })
    }
    
    /// 添加属性自定义的模型转换
    mutating func addTransformClosure(_ property: String, fromJSONClosure: @escaping (Any) -> (Any?), toJSONClosure: @escaping (Any) -> (Any?)) {
        self.customProperties[property] = Handler(fromJSONClosure: fromJSONClosure, toJSONClosure: toJSONClosure)
    }
    
}

/// JSONModel 工具
open class YJJSONModel<T> {
    
    /// 通过 json 转换模型
    /// - parameter object: 填充数据的模型
    /// - parameter json: json串
    /// - parameter designatedPath: 数据路径
    public static func transformToModel(_ object: Any, fromJSON json: String?, designatedPath: String? = nil) -> T {
        guard let _json = json else {
            return object as! T
        }
        do {
            let jsonObject = try JSONSerialization.jsonObject(with: _json.data(using: String.Encoding.utf8)!, options: .allowFragments)
            if let jsonDict = jsonObject as? [String: Any] {
                return self.transformToModel(object, fromDict: jsonDict, designatedPath: designatedPath)
            }
        } catch {
            YJLogError("[YJJSONModel] error: \(error)")
        }
        return object as! T
    }
    
    /// 通过 NSDictionary 转换模型
    public static func transformToModel(_ object: Any, fromNSDict dict: NSDictionary?, designatedPath: String? = nil) -> T {
        return self.transformToModel(object, fromDict: dict as? [String: Any], designatedPath: designatedPath)
    }
    
    /// 通过 Dictionary<String, Any> 转换模型
    public static func transformToModel(_ object: Any, fromDict dict: [String: Any]?, designatedPath: String? = nil) -> T {
        var tt = TransformTool<T>(object: object)
        tt.transformToModel(dict: dict, designatedPath: designatedPath)
        return tt.object
    }
    
    /// 模型转换为 Dictionary<String, Any>
    public static func transformToDict(_ object: Any) -> [String: Any] {
        if object is Dictionary<String, Any> || object is NSDictionary {
            return object as! [String: Any]
        }
        let tt = TransformTool<T>(object: object)
        return tt.transformToDict()
    }
    
    /// 模型转换为 json 串
    public static func transformToJSON(_ object: Any, options opt: JSONSerialization.WritingOptions = []) -> String? {
        let dict = self.transformToDict(object)
        do {
            let jsonData = try JSONSerialization.data(withJSONObject: dict, options: opt)
            return String(data: jsonData, encoding: .utf8)
        } catch {
            YJLogError("[YJJSONModel] error: \(error)")
            return nil
        }
    }
    
}
