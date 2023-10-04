//
//  CreateCardModels.swift
//  DuxerExample
//
//  Created by Kenan Alizadeh on 24.04.23.
//

import Foundation

enum AddCardViewItem {
    case text(content: TextContent)
    case input(type: AddCardViewInputItem, item: TextField.Item)
}

enum AddCardViewInputItem: Int {
    case cardLabel
    case cardNumber
    case expirationDate
    case cvv
}

struct CreateCardForm {
    var id: String?
    var label: String?
    var number: String?
    var expirationDate: String?
    var cvv: String?

    var isValid: Bool {

        guard let label,
              !label.isEmpty,
              let number,
              !number.isEmpty,
              number.count == 16,
              let expirationDate,
              expirationDate.count == 4,
              let cvv,
              cvv.count == 3
        else { return false }

        return true
    }

    var card: Card? {
        guard let id,
              let number,
              let expirationDate,
              let cvv
        else { return nil }

        return Card(
            id: id,
            label: label.orEmpty,
            number: number,
            balance: 10,
            currency: .allCases.randomElement().or(.azn),
            expirationDate: expirationDate,
            cvv: cvv
        )
    }
}
