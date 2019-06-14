//
//  Metadata.swift
//  YJCocoa
//
//  Created by 阳君 on 2019/6/10.
//

struct _class_rw_t {
    var flags: Int32
    var version: Int32
    var ro: UInt
    // other fields we don't care
    
    func class_ro_t() -> UnsafePointer<_class_ro_t>? {
        return UnsafePointer<_class_ro_t>(bitPattern: self.ro)
    }
}

struct _class_ro_t {
    var flags: Int32
    var instanceStart: Int32
    var instanceSize: Int32
    // other fields we don't care
}

// MARK: CBridge
@_silgen_name("swift_getTypeByMangledNameInContext")
public func _getTypeByMangledNameInContext(_ name: UnsafePointer<UInt8>, _ nameLength: Int, genericContext: UnsafeRawPointer?, genericArguments: UnsafeRawPointer?) -> Any.Type?

// MARK: Metadata
class Metadata {
    
    var superMetadata: Metadata?
    var name: String = ""
    var type: Any.Type
    var kind: Metadata.Kind
    var ivarList: [Metadata.Property] = []
    
    static let cacheMetaClass = YJSafetyCache<NSString, Metadata>()
    
    init() {
        self.type = Metadata.self
        self.kind = .class
    }
    
    private convenience init(type: Any.Type) {
        self.init()
        self.type = type
        self.name = "\(type)"
        let pointer: UnsafePointer<Int> = unsafeBitCast(type, to: UnsafePointer<Int>.self)
        self.kind = Metadata.Kind(flag: pointer.pointee)
        switch self.kind {
        case .struct:
            self.ivarList = Metadata.Struct(pointer: pointer).propertyDescriptions()
            break
        case .class:
            let mclass = Metadata.Class(pointer: pointer)
            self.ivarList = mclass.propertyDescriptions()
            if let superclass = mclass.pointer.pointee.superclass {
                self.superMetadata = Metadata.build(type: superclass)
            }
        }
        YJLogVerbose("[JSONModel] 解析: \(type), ivarList: \(self.ivarList)")
    }
    
    static func build(type: Any.Type) -> Metadata? {
        let name = "\(type)" as NSString
        guard name != "Swift._SwiftObject", name != "NSObject", !(type is YJJSONModelTransformModel.Type) else {
            return nil
        }
        if let metadata = Metadata.cacheMetaClass.object(forKey: name) {
            return metadata
        }
        let metadata = Metadata(type: type)
        Metadata.cacheMetaClass.setObject(metadata, forKey: name)
        return metadata
    }
    
}

// MARK: Metadata + Kind
// https://github.com/apple/swift/blob/master/docs/ABI/TypeMetadata.rst
extension Metadata {
    enum Kind {
        case `struct`
        case `class`
        init(flag: Int) {
            let MetadataKindIsNonHeap = 0x200
            switch flag {
            case (0 | MetadataKindIsNonHeap): self = .struct
            default: self = .class
            }
        }
    }
}

// MARK: Metadata + ivar
extension Metadata {
    struct Property {
        let name: String
        let type: Any.Type
        let offset: Int
    }
}

// MARK: Metadata + Struct
extension Metadata {
    
    struct Struct : ContextDescriptorType {
        
        var pointer: UnsafePointer<_Metadata._Struct>
        
        var kind: Metadata.Kind? {
            return .struct
        }

        var contextDescriptorOffsetLocation: Int {
            return 1
        }
        
        var genericArgumentOffsetLocation: Int {
            return 2
        }
        
        var genericArgumentVector: UnsafeRawPointer? {
            let pointer = UnsafePointer<Int>(self.pointer)
            let base = pointer.advanced(by: genericArgumentOffsetLocation)
            if base.pointee == 0 {
                return nil
            }
            return UnsafeRawPointer(base)
        }
        
        func propertyDescriptions() -> [Metadata.Property] {
            var result: [Metadata.Property] = []
            let genericContext = self.contextDescriptorPointer
            let genericArguments = self.genericArgumentVector
            if let fieldOffsets = self.fieldOffsets,
                let reflectionFieldDescriptor = self.reflectionFieldDescriptor {
                for i in 0..<self.numberOfFields {
                    let name = reflectionFieldDescriptor.fieldRecords[i].fieldName
                    if let cMangledTypeName = reflectionFieldDescriptor.fieldRecords[i].mangledTypeName,
                        let fieldType = _getTypeByMangledNameInContext(cMangledTypeName, 256, genericContext: genericContext, genericArguments: genericArguments) {
                        result.append(Metadata.Property(name: name, type: fieldType, offset: fieldOffsets[i]))
                    }
                }
            }
            return result
        }
    }
}

// MARK: Metadata + Class
extension Metadata {
    
    struct Class : ContextDescriptorType {
        
        var pointer: UnsafePointer<_Metadata._Class>
        
        var kind: Metadata.Kind? {
            return .class
        }
        
        var contextDescriptorOffsetLocation: Int {
            return is64BitPlatform ? 8 : 11
        }
        
        var superclass: Class? {
            guard let superclass = pointer.pointee.superclass else {
                return nil
            }
            let type = "\(superclass)"
            guard type != "Swift._SwiftObject", type != "NSObject" else {
                return nil
            }
            return Metadata.Class(pointer: unsafeBitCast(superclass, to: UnsafePointer<Int>.self))
        }
        
        var vTableSize: Int {
            // memory size after ivar destroyer
            return Int(pointer.pointee.classObjectSize - pointer.pointee.classObjectAddressPoint) - (contextDescriptorOffsetLocation + 2) * MemoryLayout<Int>.size
        }
        
        // reference: https://github.com/apple/swift/blob/master/docs/ABI/TypeMetadata.rst#generic-argument-vector
        var genericArgumentVector: UnsafeRawPointer? {
            let pointer = UnsafePointer<Int>(self.pointer)
            var superVTableSize = 0
            if let _superclass = self.superclass {
                superVTableSize = _superclass.vTableSize / MemoryLayout<Int>.size
            }
            let base = pointer.advanced(by: contextDescriptorOffsetLocation + 2 + superVTableSize)
            if base.pointee == 0 {
                return nil
            }
            return UnsafeRawPointer(base)
        }
        
        func propertyDescriptions() -> [Metadata.Property] {
            var result: [Metadata.Property] = []
            if let fieldOffsets = self.fieldOffsets,
                let reflectionFieldDescriptor = self.reflectionFieldDescriptor,
                let genericContext = self.contextDescriptorPointer,
                let genericArguments = self.genericArgumentVector {
                for i in 0..<self.numberOfFields {
                    let name = reflectionFieldDescriptor.fieldRecords[i].fieldName
                    if let cMangledTypeName = reflectionFieldDescriptor.fieldRecords[i].mangledTypeName,
                        let fieldType = _getTypeByMangledNameInContext(cMangledTypeName, 256, genericContext: genericContext, genericArguments: genericArguments) {
                        result.append(Metadata.Property(name: name, type: fieldType, offset: fieldOffsets[i]))
                    }
                }
            }
            //  class 中属性的 offset 可能会发生变化
            if let firstInstanceStart = self.pointer.pointee.class_rw_t()?.pointee.class_ro_t()?.pointee.instanceStart,
                let firstProperty = result.first?.offset {
                return result.map({ (ivar) -> Metadata.Property in
                    let offset = ivar.offset - firstProperty + Int(firstInstanceStart)
                    return Metadata.Property(name: ivar.name, type: ivar.type, offset: offset)
                })
            }
            return result
        }
    }
    
}

var is64BitPlatform: Bool {
    return MemoryLayout<Int>.size == MemoryLayout<Int64>.size
}

// MARK: - _Metadata
struct _Metadata {
   
    struct _Struct {
        var kind: Int
        var contextDescriptorOffset: Int
        var parent: Metadata?
    }
    
    struct _Class {
        var kind: Int
        var superclass: Any.Type?
        var reserveword1: Int
        var reserveword2: Int
        var rodataPointer: UInt
        var classFlags: UInt32
        var instanceAddressPoint: UInt32
        var instanceSize: UInt32
        var instanceAlignmentMask: UInt16
        var runtimeReservedField: UInt16
        var classObjectSize: UInt32
        var classObjectAddressPoint: UInt32
        var nominalTypeDescriptor: Int
        var ivarDestroyer: Int
        // other fields we don't care
        
        func class_rw_t() -> UnsafePointer<_class_rw_t>? {
            if MemoryLayout<Int>.size == MemoryLayout<Int64>.size {
                let fast_data_mask: UInt64 = 0x00007ffffffffff8
                let databits_t: UInt64 = UInt64(self.rodataPointer)
                return UnsafePointer<_class_rw_t>(bitPattern: UInt(databits_t & fast_data_mask))
            } else {
                return UnsafePointer<_class_rw_t>(bitPattern: self.rodataPointer & 0xfffffffc)
            }
        }
    }
    
}

