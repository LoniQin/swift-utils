
//
//  CharacterTestCase.swift
//
//
//  Created by lonnie on 2020/10/17.
//

import Foundation
import XCTest
@testable import SwiftUtils

final class CharacterTestCase: XCTestCase {
    func testCharacter() {
        [Character].numbers.assert.equal(Array("0123456789"))
        [Character].lowercasedAlphabets.assert.equal(Array("abcdefghijklmnopqrstuvwxyz"))
    }
}
