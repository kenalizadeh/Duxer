//
//  OrderCardModels.swift
//  DuxerExample
//
//  Created by Kenan Alizadeh
//

import Foundation

struct OrderCardForm {
    var label: String = ""
    var currency: Currency = .azn

    var isValid: Bool {

        guard !self.label.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
        else { return false }

        return true
    }

    var card: Card? {
        Card(
            id: UUID().uuidString,
            label: self.label,
            number: self.generatedCardNumber,
            balance: 10,
            currency: self.currency,
            expirationDate: self.dateFormatter.string(from: self.expirationDate),
            cvv: self.generatedCVV
        )
    }

    private var generatedCardNumber: String {
        Array(1 ... 16).map { _ in Int.random(in: 1 ... 9) }.map(String.init).joined()
    }

    private var generatedCVV: String {
        Array(1 ... 3).map { _ in Int.random(in: 1 ... 9) }.map(String.init).joined()
    }

    private var expirationDate: Date {
        Calendar.current.date(byAdding: DateComponents(year: 5), to: Date()).or(Date())
    }

    private var dateFormatter: DateFormatter = .build {
        $0.dateFormat = "MM/yy"
    }
}

enum OrderCardViewItem {
    case text(content: TextContent)
    case input(type: LinkCardViewInputItem, item: TextField.Item)
    case options([Currency])
}
