//
//  Int.swift
//  
//
//  Created by lonnie on 2020/8/22.
//

import Foundation

public extension Int {
    
    func toBinaryString() -> String {
        var s = [Int]()
        var n = self
        while n > 0 {
            s.append(n % 2)
            n = n / 2
        }
        var text = ""
        while let value = s.popLast() {
            text.append(value.description)
        }
        return text
    }
    
    @discardableResult
    mutating func decreasing() -> Int {
        self -= 1
        return self
    }
    
    @discardableResult
    mutating func increasing() -> Int {
        self += 1
        return self
    }
}

extension Int: NumberConvertable {
    
    public var int: Int { self  }
    
    public var uint: UInt { UInt(self)  }
    
    public var double: Double { Double(self) }
    
    public var float: Float { Float(self) }
    
}
