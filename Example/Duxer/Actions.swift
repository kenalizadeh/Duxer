//
//  Actions.swift
//  DuxerExample
//
//  Created by Kenan Alizadeh
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

enum NavigationAction: DXAction {
    case launch
    case registration
    case home
    case cardDetails(card: Card)
    case cardOrder
    case cardLink
    case transfer(card: Card)
}

extension NavigationAction: Equatable {
    static func == (lhs: NavigationAction, rhs: NavigationAction) -> Bool {
        false
//        switch (lhs, rhs) {
//        case (.launch, .launch), (.home, .home), (.registration, .registration), (.cardOrder, .cardOrder), (.cardLink, .cardLink):
//            return true
//
//        case let (.cardDetails(lCard), .cardDetails(rCard)):
//            return lCard == rCard
//
//        case let (.transfer(lCard), .transfer(rCard)):
//            return lCard == rCard
//
//        default:
//            return false
//        }
    }
}
