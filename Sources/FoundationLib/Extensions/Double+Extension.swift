//
//  Double+Extension.swift
//
//
//  Created by lonnie on 2020/8/19.
//
import Foundation

public extension Double {
    
    var km: Double { times(1000) }
    
    func times(_ double: Double) -> Double {
        self * double
    }
    
}
