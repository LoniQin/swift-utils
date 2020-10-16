//
//  functions.swift
//  
//
//  Created by lonnie on 2020/9/19.
//

import Foundation

func dataPath() -> String {
    let file = #file
    var comp = file.components(separatedBy: "/")
    comp.removeLast()
    comp.append("data")
    return comp.joined(separator: "/")
}
