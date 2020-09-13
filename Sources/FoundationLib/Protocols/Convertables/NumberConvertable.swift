//
//  NumberConvertable.swift
//  
//
//  Created by lonnie on 2020/8/22.
//

import Foundation

public protocol NumberConvertable {
    
    var int: Int { get }
    
    var uint: UInt { get }

    var double: Double { get }

    var float: Float { get }
}

