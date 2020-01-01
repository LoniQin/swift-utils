//
//  UInt.swift
//  
//
//  Created by lonnie on 2020/8/22.
//

import Foundation

extension UInt: NumberConvertable {
    
    public var int: Int { Int(self)  }
    
    public var uint: UInt { self  }
    
    public var double: Double { Double(self) }
    
    public var float: Float { Float(self) }
    
}
