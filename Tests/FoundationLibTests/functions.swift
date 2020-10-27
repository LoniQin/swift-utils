//
//  functions.swift
//  
//
//  Created by lonnie on 2020/9/19.
//

import Foundation

func projectPath() -> String {
    let file = #file
    var comp = file.components(separatedBy: "/")
    comp.removeLast(3)
    return comp.joined(separator: "/")
}

func dataPath() -> String {
    let file = #file
    var comp = file.components(separatedBy: "/")
    comp.removeLast()
    comp.append("data")
    return comp.joined(separator: "/")
}
