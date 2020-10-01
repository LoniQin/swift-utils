//
//  NSObject.swift
//
//
//  Created by lonnie on 2020/8/19.
//

import Foundation

public extension NSObject {
    
    func setAssociatedValue(_ value: Any?, with key: UnsafeRawPointer, _ option: objc_AssociationPolicy = .OBJC_ASSOCIATION_COPY) {
         objc_setAssociatedObject(self, key, value, option)
    }
     
    func getAssociatedValue<T>(with key: UnsafeRawPointer) -> T? {
         objc_getAssociatedObject(self, key) as? T
    }
    
    func `try`<T>(block: () throws -> T) -> T? {
        do {
            return try block()
        } catch {
            return nil
        }
    }
    
    static func className() -> String {
        classForCoder().description()
    }
    
}

extension NSObject: Then {}

protocol Then {}

extension Then {
    
    @discardableResult
    public func then(_ block: @escaping (Self) -> Void) -> Self {
        block(self)
        return self
    }
    
    public func `do`(_ block: @escaping (Self) -> Void) {
        block(self)
    }
    
    @discardableResult
    public func `with`(_ block: @escaping (Self) -> Void) -> Self {
        block(self)
        return self
    }
    
}
