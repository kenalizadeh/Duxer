//
//  TransferModels.swift
//  DuxerExample
//
//  Created by 004230 on 24.04.23.
//

import UIKit

struct C2CTransfer: Equatable {
    let sender: Card
    let recipient: Card
    let amount: Double
    let date: Date
}

enum TransferViewItem {
    case card(Card)
    case text(Label.Item)
    case icon(UIImageView.Item)
    case input(item: TextField.Item)
}

struct TransferForm: Equatable {
    let sender: Card
    var recipient: Card?
    var amount: Double = 0

    var isValid: Bool {

        guard self.recipient.isNotNil,
              self.sender.balance > self.amount
        else { return false }

        return true
    }

    var transferData: C2CTransfer? {

        guard let recipient
        else { return nil }

        return C2CTransfer(
            sender: self.sender,
            recipient: recipient,
            amount: self.amount,
            date: Date()
        )
    }
}
