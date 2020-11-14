//
//  functions.swift
//  
//
//  Created by lonnie on 2020/9/19.
//

import Foundation
@testable import FoundationLib
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

func bootstrap_document(@ArrayBuilder _ builder: @escaping () -> [HTMLNode] = { [HTMLNode]() }) -> html {
    html {
        head {
            title("Directed Graph")
            link(href: "https://cdn.jsdelivr.net/npm/bootstrap@4.5.3/dist/css/bootstrap.min.css")
            script()(
                src: "https://code.jquery.com/jquery-3.5.1.slim.min.js",
                integrity: "sha384-DfXdz2htPH0lsSSs5nCTpuj/zy4C+OGpamoFVy38MVBnE+IbbVYUew+OrCXaRkfj",
                crossorigin: "anonymous"
            ).with { (node) in
                node.contents = [" "]
            }
            script()(
                src: "https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js",
                integrity: "sha384-9/reFTGAW83EW2RDu2S0VKaIzap3H66lZH81PoYlFhbGU+6BZp6G7niu735Sk7lN",
                crossorigin: "anonymous"
            ).with { (node) in
                node.contents = [" "]
            }
            script()(
                src:"https://cdn.jsdelivr.net/npm/bootstrap@4.5.3/dist/js/bootstrap.min.js",
                integrity: "sha384-w1Q4orYjBQndcko6MimVbzY0tgp4pWB4lZ7lr30WKz0vr/aWKhXdBNmNb5D92v7s",
                crossorigin: "anonymous"
            ).with { (node) in
                node.contents = [" "]
            }
        }
        body {
            div("", builder)(class: "container")
        }
    }
}
