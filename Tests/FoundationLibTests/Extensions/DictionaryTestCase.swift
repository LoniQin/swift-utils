
//
//  DictionaryTestCase.swift
//
//
//  Created by lonnie on 2020/10/16.
//

import Foundation
import XCTest
@testable import FoundationLib

final class DictionaryTestCase: XCTestCase {
    
    func testDictonary() {
        let dic = ["a": 1, "b": 2]
        do {
            let a: Int = try dic.get("a")
            a.assert.equal(1)
            let b: Int? = dic.get("b")
            b.assert.equal(2)
        } catch  {
            XCTFail()
        }
        do {
            let _ : Int = try dic.get("c")
            XCTFail()
        } catch {
            
        }
        
    }
    
    func testDictionaryWithArrayBuilder() {
        let dic = Dictionary {
            ("A", 1)
            ("B", 2)
            ("C", 3)
            ("D", 4)
        }
        dic.assert.equal(["A": 1, "B": 2, "C": 3, "D": 4])
    }
    
}
