//
//  File.swift
//  
//
//  Created by lonnie on 2020/8/22.
//

import Foundation
extension Int: NumberConvertable {
    
    public var int: Int { self  }
    
    public var uint: UInt { UInt(self)  }
    
    public var double: Double { Double(self) }
    
    public var float: Float { Float(self) }
    
}
