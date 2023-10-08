//
//  Actions.swift
//  DuxerExample
//
//  Created by Kenan Alizadeh on 23.04.23.
//

import Duxer

enum UserAction: DXAction {
    case register(UserData)
}

enum CardAction: DXAction {
    case create(Card)
    case delete(Card)
    case updateCardBalance(cardID: String, balance: Double)
}

enum TransferAction: DXAction {
    case pendingTransferFormUpdate(TransferForm)
    case transfer(C2CTransfer)
    case error(DXTransactionError)
    case reset
}
