//
//  TransformTool.swift
//  Pods
//
//  Created by 阳君 on 2019/6/10.
//

import Foundation

let CacheMetadataProperty = YJSafetyCache<NSString, NSArray>()

// MARK: - Base
struct TransformTool<T> {
    
    var object: T
    var metadata: Metadata
    lazy var headPointer: UnsafeMutablePointer<Int8> = {
        if self.metadata.kind == .class {
            let opaquePointer = Unmanaged.passUnretained(object as AnyObject).toOpaque()
            let mutableTypedPointer = opaquePointer.bindMemory(to: Int8.self, capacity: MemoryLayout<T>.stride)
            return UnsafeMutablePointer<Int8>(mutableTypedPointer)
        } else {
            return withUnsafeMutablePointer(to: &object) {
                return UnsafeMutableRawPointer($0).bindMemory(to: Int8.self, capacity: MemoryLayout<T>.stride)
            }
        }
    }()
    
    init(object: T) {
        self.object = object
        self.metadata = Metadata.build(type: type(of: object))!
    }
    
    func getJsonKey(property: Metadata.Property, mapper: YJJSONModelTransformMapper) -> String? {
        guard !mapper.ignoredProperties.contains(property.name) else {
            return nil
        }
        var key = mapper.optionalProperties[property.name]
        if key == nil {
            key = property.name
            if !mapper.isCaseSensitive {
                key = key?.lowercased()
            }
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
        for property in self.metadata.allProperties {
            let propAddr = self.headPointer.advanced(by: property.offset)
            if let key = self.getJsonKey(property: property, mapper: mapper), let rawValue = dict?[key] {
                if let convertedValue = self.convertValue(rawValue: rawValue, property: property, mapper: mapper) {
                    self.assignProperty(convertedValue: convertedValue, address: propAddr, instance: object, property: property, mapper: mapper)
                } else {
                    YJLogError("[YJCocoa] \(T.self).\(property.name) 转换异常数据：\(rawValue)")
                }
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
    
    func assignProperty(convertedValue: Any, address: UnsafeMutableRawPointer, instance: Any, property:  Metadata.Property, mapper: YJJSONModelTransformMapper) {
        if mapper.kvcProperties.contains(property.name) {
            (instance as! NSObject).setValue(convertedValue, forKey: property.name)
        } else {
            extensions(of: property.type).write(convertedValue, to: address)
        }
    }
    
}

// MARK: - Dictionary
extension TransformTool {
    
    mutating func transformToDict() -> Dictionary<String, Any> {
        var dict = Dictionary<String, Any>()
        let mapper = YJJSONModelTransformMapper()
        (object as? YJJSONModelTransformModel)?.transform(mapper: mapper)
        for property in self.metadata.allProperties {
            let address = self.headPointer.advanced(by: property.offset)
            if let key = self.getJsonKey(property: property, mapper: mapper) {
                dict[key] = self.jsonValue(forInstance: object, mapper: mapper, property: property, address: address)
            }
        }
        (object as? YJJSONModelTransformModel)?.transform(toDict: &dict)
        return dict
    }
    
    func jsonValue(forInstance instance: Any, mapper: YJJSONModelTransformMapper, property: Metadata.Property, address: UnsafeRawPointer) -> Any? {
        var value: Any?
        if mapper.kvcProperties.contains(property.name) {
            value = (instance as! NSObject).value(forKey: property.name)
        } else {
            value = extensions(of: property.type).value(from: address)
        }
        guard let object = value else {
            return nil
        }
        if let transformBasic = property.type as? YJJSONModelTransformBasic.Type {
            value = transformBasic.transform(toJSON: object)
        } else if let transformCustom = mapper.customProperties[property.name] {
            value = transformCustom.toJSONClosure(object)
        }
        return value
    }
    
}
