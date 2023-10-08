//
//  StringFormatters.swift
//  DuxerExample
//
//  Created by Kenan Alizadeh
//

import Foundation

struct PhoneNumberFormatter: MaskedStringFormatter {
    let mask: String = "+994 ## ### ## ##"
    let maskCharacter: Character = "#"

    func decoded(text: String) -> String {

        let text = text
            .prefix(self.mask.count)
            .replacingOccurrences(of: "+994 ", with: "")
            .replacingOccurrences(of: " ", with: "")
            .replacingOccurrences(of: "-", with: "")

        return text
    }
}

struct CardNumberFormatter: MaskedStringFormatter {
    let mask: String = "#### #### #### ####"
    let maskCharacter: Character = "#"

    func decoded(text: String) -> String {

        let text = text
            .prefix(self.mask.count)
            .replacingOccurrences(of: " ", with: "")

        return text
    }
}

struct CardExpirationDateFormatter: MaskedStringFormatter {
    let mask: String = "##/##"
    let maskCharacter: Character = "#"

    func decoded(text: String) -> String {

        let text = text
            .prefix(self.mask.count)
            .replacingOccurrences(of: "/", with: "")

        return text
    }
}
