//
//  CardDetailModels.swift
//  DuxerExample
//
//  Created by Kenan Alizadeh
//

import Foundation

struct Card: Equatable {
    let id: String
    let label: String
    let number: String
    var balance: Double
    let network: CardNetwork
    let currency: Currency
    let expirationDate: String
    let cvv: String

    init(id: String, label: String, number: String, balance: Double, currency: Currency, expirationDate: String, cvv: String) {
        self.id = id
        self.label = label
        self.number = number
        self.balance = balance
        self.network = CardNetwork.allCases.randomElement().or(.visa)
        self.currency = currency
        self.expirationDate = expirationDate
        self.cvv = cvv
    }
}

enum CardNetwork: CaseIterable {
    case visa
    case amex
    case maestro
    case mastercard
    case unionpay

    var icon: Image {
        switch self {
        case .visa:
            return Image.cardTypeVisa

        case .amex:
            return Image.cardTypeAmex

        case .maestro:
            return Image.cardTypeMaestro

        case .mastercard:
            return Image.cardTypeMaster

        case .unionpay:
            return Image.cardTypeUnionpay
        }
    }
}

enum CardDetailViewItem {
    case cardDetails
    case text(Label.Item)
    case button(Button.Item)
    case transaction(C2CTransfer)
}

enum Currency: String, CaseIterable {
    case azn
    case usd
    case rub

    var title: String {
        self.rawValue.uppercased()
    }

    var symbol: String {
        switch self {
        case .azn: return "₼"
        case .usd: return "$"
        case .rub: return "₽"
        }
    }
}
