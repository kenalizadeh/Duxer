//
//  Actions.swift
//  DuxerExample
//
//  Created by 004230 on 23.04.23.
//

import Duxer

enum DXAction: Action {
    case user(DXUserAction)
    case card(DXCardAction)
    case transfer(DXTransferAction)
    case print(String)
}

enum DXUserAction: Action {
    case register(UserData)
}

enum DXCardAction: Action {
    case create(Card)
    case delete(Card)
    case updateCardBalance(cardID: String, balance: Double)
}

enum DXTransferAction: Action {
    case pendingTransferFormUpdate(TransferForm)
    case transfer(C2CTransfer)
}
