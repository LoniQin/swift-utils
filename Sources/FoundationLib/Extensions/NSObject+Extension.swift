//
//  NSObject+Extension.swift
//
//
//  Created by lonnie on 2020/8/19.
//

import Foundation

public extension NSObject {
    
    func setAssociatedValue(_ value: Any?, with key: inout String, _ option: objc_AssociationPolicy = .OBJC_ASSOCIATION_COPY) {
         objc_setAssociatedObject(self, &key, value, option)
    }
     
    func getAssociatedValue<T>(with key: inout String) -> T? {
         objc_getAssociatedObject(self, &key) as? T
    }
    
}
