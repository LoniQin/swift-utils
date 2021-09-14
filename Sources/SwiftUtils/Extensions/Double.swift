//
//  Double.swift
//
//
//  Created by lonnie on 2020/8/19.
//
import Foundation

extension Double: NumberConvertable {
    
    public var int: Int { Int(self)  }
    
    public var uint: UInt { UInt(self)  }
    
    public var double: Double { self }
    
    public var float: Float { Float(self) }
    
}
