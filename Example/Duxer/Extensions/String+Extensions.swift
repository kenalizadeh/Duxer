//
//  String+Extensions.swift
//  DuxerExample
//
//  Created by Kenan Alizadeh on 23.04.23.
//

import Foundation

extension String {
    /// Validate regular expression
    /// - Example: "mail@domain.az" ~= "^[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}$"
    /// - Parameters:
    ///   - lhs: left String
    ///   - rhs: righ String
    /// - Returns: Result of regex validation
    static func ~= (lhs: String, rhs: String) -> Bool {
        guard let regex = try? NSRegularExpression(pattern: rhs) else { return false }
        let range = NSRange(location: 0, length: lhs.utf16.count)
        return regex.firstMatch(in: lhs, options: [], range: range) != nil
    }

    /// Validate regular expression
    /// - Example: "mail@domain.az".matches("^[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}$")
    /// - Parameter regex: regular expression string
    /// - Returns: Result of regex validation
    func matches(_ regex: String) -> Bool {
        self ~= regex
    }
}
