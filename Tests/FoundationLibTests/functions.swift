//
//  functions.swift
//  
//
//  Created by lonnie on 2020/9/19.
//

import Foundation

func dataPath() -> String {
    var comp = #file.components(separatedBy: "/")
    comp.removeLast()
    comp.append("data")
    return comp.joined(separator: "/")
}
