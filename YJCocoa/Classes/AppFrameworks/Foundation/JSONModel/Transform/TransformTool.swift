//
//  TransformTool.swift
//  Pods
//
//  Created by 阳君 on 2019/6/10.
//

import Foundation

typealias Byte = Int8

// MARK: - Base
class TransformTool {
    
    static var shared = TransformTool()
    let cacheProperty = YJSafetyCache<NSString, NSArray>()
    var cacheType = [String : Metadata.Kind]()
    
    func getProperties(forType type: Any.Type) -> [Metadata.Property] {
        let key = "\(type)" as NSString
        if let properties = self.cacheProperty.object(forKey: key) as? [Metadata.Property] {
            return properties
        }
        let properties = self.getProperties(forMetadata: Metadata.build(type: type)!)
        self.cacheProperty.setObject(properties as AnyObject, forKey: key)
        return properties
    }
    
    func getProperties(forMetadata metadata: Metadata) -> [Metadata.Property] {
        self.cacheType[metadata.name] = metadata.kind
        let properties = metadata.ivarList
        if let superMetadata = metadata.superMetadata {
            return self.getProperties(forMetadata: superMetadata) + properties
        }
        return properties
    }
    
    func headPointer(_ object: inout Any, type: Any.Type) -> UnsafeMutablePointer<Int8> {
        let stride = MemoryLayout.stride(ofValue: object)
        let kind = self.cacheType["\(type)"]!
        if kind == .class {
            let opaquePointer = Unmanaged.passUnretained(object as AnyObject).toOpaque()
            let mutableTypedPointer = opaquePointer.bindMemory(to: Int8.self, capacity: stride)
            return UnsafeMutablePointer<Int8>(mutableTypedPointer)
        } else {
            return withUnsafeMutablePointer(to: &object) {
                return UnsafeMutableRawPointer($0).bindMemory(to: Int8.self, capacity: stride)
            }
        }
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
    
    func transformToModel(_ object: inout Any, type: Any.Type, dict: Dictionary<String, Any>?, designatedPath: String? = nil) {
        var dict = dict
        if let path = designatedPath {
            dict = self.getInnerObject(inside: dict, by: path)
        }
        guard dict != nil else {
            return
        }
        let mapper = YJJSONModelTransformMapper()
        (object as? YJJSONModelTransformModel)?.transform(mapper: mapper)
        let properties = self.getProperties(forType: type)
        let headPointer = self.headPointer(&object, type: type)
        for property in properties {
            let propAddr = headPointer.advanced(by: property.offset)
            if let key = self.getJsonKey(property: property, mapper: mapper), let rawValue = dict?[key] {
                if let convertedValue = self.convertValue(rawValue: rawValue, property: property, mapper: mapper) {
                    assignProperty(convertedValue: convertedValue, address: propAddr, instance: object, property: property, mapper: mapper)
                } else {
                    YJLogError("[YJCocoa] \(type).\(property.name) 转换异常数据：\(rawValue)")
                }
            }
        }
        (object as? YJJSONModelTransformModel)?.transform(fromDict: dict!)
    }
    
    func getInnerObject(inside object: Dictionary<String, Any>?, by designatedPath: String?) -> Dictionary<String, Any>? {
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
    
    func transformToDict(_ object: Any, type: Any.Type) -> Dictionary<String, Any> {
        var dict = Dictionary<String, Any>()
        let mapper = YJJSONModelTransformMapper()
        (object as? YJJSONModelTransformModel)?.transform(mapper: mapper)
        let properties = self.getProperties(forType: type)
        var object = object
        let headPointer = self.headPointer(&object, type: type)
        print(headPointer)
        for property in properties {
            let address = headPointer.advanced(by: property.offset)
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
