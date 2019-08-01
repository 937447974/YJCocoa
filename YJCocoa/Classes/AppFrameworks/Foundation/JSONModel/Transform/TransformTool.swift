//
//  TransformTool.swift
//  YJCocoa
//
//  HomePage:https://github.com/937447974/YJCocoa
//  YJ技术支持群:557445088
//
//  Created by 阳君 on 2019/6/10.
//  Copyright © 2016-现在 YJCocoa. All rights reserved.
//

import Foundation

let CacheMetadataProperty = YJSafetyCache<NSString, NSArray>()

// MARK: - Base
struct TransformTool<T> {
    
    var object: T
    var metadata: Metadata
    lazy var headPointer: UnsafeMutablePointer<Int8> = {
        let capacity = MemoryLayout.stride(ofValue: self.object)
        if self.metadata.kind == .class {
            let opaquePointer = Unmanaged.passUnretained(object as AnyObject).toOpaque()
            let mutableTypedPointer = opaquePointer.bindMemory(to: Int8.self, capacity: capacity)
            return UnsafeMutablePointer<Int8>(mutableTypedPointer)
        } else {
            return withUnsafeMutablePointer(to: &self.object) {
                return UnsafeMutableRawPointer($0).bindMemory(to: Int8.self, capacity: capacity)
            }
        }
    }()
    
    init(object: Any) {
        self.object = object as! T
        self.metadata = Metadata.build(type: type(of: object))!
    }
    
    func getJsonKey(propertyName: String, mapper: YJJSONModelTransformMapper) -> String? {
        guard !mapper.ignoredProperties.contains(propertyName) else {
            return nil
        }
        guard let key = mapper.optionalProperties[propertyName] else {
            guard mapper.isCaseSensitive else {
                return propertyName.lowercased()
            }
            return propertyName
        }
        return key
    }
    
}

// MARK: - Model
extension TransformTool {
    
    mutating func transformToModel(dict: [String: Any]?, designatedPath: String? = nil) {
        var dict = dict
        if let path = designatedPath {
            dict = self.getInnerObject(inside: dict, by: path)
        }
        guard dict != nil else {
            return
        }
        let mapper = YJJSONModelTransformMapper()
        (object as? YJJSONModelTransformModel)?.transform(mapper: mapper)
        if !mapper.isCaseSensitive {
            dict = self.processDict(dict!)
        }
        for property in self.metadata.allProperties {
            let propAddr = self.headPointer.advanced(by: property.offset)
            if let key = self.getJsonKey(propertyName: property.name, mapper: mapper), let rawValue = dict?[key] {
                if let convertedValue = self.convertValue(rawValue: rawValue, property: property, mapper: mapper) {
                    self.assignProperty(convertedValue: convertedValue, address: propAddr, property: property, mapper: mapper)
                } else {
                    YJLogError("[YJCocoa] \(self.metadata.type).\(property.name) 转换异常数据：\(rawValue)")
                }
            } else {
                YJLogVerbose("[YJCocoa] \(self.metadata.type).\(property.name) 跳过转换")
            }
        }
        (object as? YJJSONModelTransformModel)?.transform(fromDict: dict!)
        return
    }
    
    func getInnerObject(inside object: [String: Any]?, by designatedPath: String?) -> [String: Any]? {
        var result = object
        if let paths = designatedPath?.components(separatedBy: ".") {
            for path in paths {
                result = result?[path] as? [String : Any]
            }
        }
        return result
    }
    
    func processDict(_ dict: [String: Any]) -> [String: Any]  {
        var result = [String: Any]()
        for (key, value) in dict {
            result[key.lowercased()] = value
        }
        return result
    }
    
    func convertValue(rawValue: Any, property: Metadata.Property, mapper: YJJSONModelTransformMapper) -> Any? {
        if rawValue is NSNull { return nil }
        if let transformBasic = property.type as? YJJSONModelTransformBasic.Type {
            return transformBasic.transform(fromJSON: rawValue)
        } else if let transformCustom = mapper.customProperties[property.name] {
            return transformCustom.fromJSONClosure(rawValue)
        } else {
            return extensions(of: property.type).takeValue(from: rawValue)
        }
    }
    
    func assignProperty(convertedValue: Any, address: UnsafeMutableRawPointer, property:  Metadata.Property, mapper: YJJSONModelTransformMapper) {
        if mapper.kvcProperties.contains(property.name) {
            (self.object as! NSObject).setValue(convertedValue, forKey: property.name)
        } else {
            extensions(of: property.type).write(convertedValue, to: address)
        }
    }
    
}

// MARK: - Dictionary
extension TransformTool {
    
    func transformToDict() -> Dictionary<String, Any> {
        var dict = Dictionary<String, Any>()
        let mirror = Mirror(reflecting: self.object)
        guard let displayStyle = mirror.displayStyle else {
            return dict
        }
        switch displayStyle {
        case .class, .struct:
            let mapper = YJJSONModelTransformMapper()
            (self.object as? YJJSONModelTransformModel)?.transform(mapper: mapper)
            self.transformToDict(mapper: mapper, mirror: mirror, dict: &dict)
        default:
            break
        }
        (self.object as? YJJSONModelTransformModel)?.transform(toDict: &dict)
        return dict
    }
    
    func transformToDict(mapper: YJJSONModelTransformMapper, mirror: Mirror, dict: inout Dictionary<String, Any>) {
        let name = "\(mirror.subjectType)" as NSString
        for prefix in ["Swift", "UI", "NS", "WK", "CA", "_", "Any"] {
            if name.hasPrefix(prefix) {
                return
            }
        }
        self.transformToDict(mapper: mapper, children: mirror.children, dict: &dict)
        if let superclassMirror = mirror.superclassMirror {
            self.transformToDict(mapper: mapper, mirror: superclassMirror, dict: &dict)
        }
    }
    
    func transformToDict(mapper: YJJSONModelTransformMapper, children: Mirror.Children, dict: inout Dictionary<String, Any>) {
        for item in children {
            if let label = item.label, let key = self.getJsonKey(propertyName: label, mapper: mapper) {
                var value: Any? = item.value
                if let transformCustom = mapper.customProperties[label] {
                    value = transformCustom.toJSONClosure(value!)
                } else {
                    let type = Mirror(reflecting: value!).subjectType
                    if let transformBasic = type as? YJJSONModelTransformBasic.Type {
                        value = transformBasic.transform(toJSON: value!)
                    }
                }
                dict[key] = value
            }
        }
    }
    
}
