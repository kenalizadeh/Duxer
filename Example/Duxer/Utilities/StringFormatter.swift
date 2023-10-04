//
//  StringFormatter.swift
//  DuxerExample
//
//  Created by Kenan Alizadeh on 23.04.23.
//

import Foundation

public protocol StringFormatter {
    func encoded(text: String) -> String
    func decoded(text: String) -> String
}

public protocol MaskedStringFormatter: StringFormatter {
    var mask: String { get }
    var maskCharacter: Character { get }
}

public extension MaskedStringFormatter {
    func encoded(text: String) -> String {
        guard !text.isEmpty else { return "" }

        var result = ""
        var startIndex = text.startIndex

        for character in mask where startIndex < text.endIndex {
            if character == maskCharacter {
                result.append(text[startIndex])
                startIndex = text.index(after: startIndex)
            } else {
                result.append(character)
            }
        }

        return result
    }
}

public struct DefaultStringFormatter: StringFormatter {
    public init() {}

    public func encoded(text: String) -> String { return text }
    public func decoded(text: String) -> String { return text }
}
