/*
 * Copyright 1999-2101 Alibaba Group.
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *      http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

//
//  AnyExtension.swift
//  HandyJSON
//
//  Created by zhouzhuo on 08/01/2017.
//

protocol AnyExtensions {}

extension AnyExtensions {
    
    public static func value(from storage: UnsafeRawPointer) -> Any? {
        let pointee = storage.assumingMemoryBound(to: self).pointee
        guard "\(pointee)" != "nil" else {
            return nil
        }
        return pointee
    }
    
    public static func write(_ value: Any, to storage: UnsafeMutableRawPointer) {
        guard let this = value as? Self else {
            return
        }
        storage.assumingMemoryBound(to: self).pointee = this
    }
    
    public static func takeValue(from anyValue: Any) -> Self? {
        return anyValue as? Self
    }
}

func extensions(of type: Any.Type) -> AnyExtensions.Type {
    struct Extensions : AnyExtensions {}
    var extensions: AnyExtensions.Type = Extensions.self
    withUnsafePointer(to: &extensions) { pointer in
        UnsafeMutableRawPointer(mutating: pointer).assumingMemoryBound(to: Any.Type.self).pointee = type
    }
    return extensions
}
