//
//  AppState.swift
//  DuxerExample
//
//  Created by Kenan Alizadeh on 23.04.23.
//

import Foundation
import Duxer

struct AppState: Equatable {
    var user: UserState = .init()
    var card: CardState = .init()
    var transaction: TransactionState = .init()
}

struct UserState: Equatable {
    var userData: UserData?

    var isLoggedIn: Bool {
        self.userData.isNotNil
    }
}

struct CardState: Equatable {
    var cards: [Card] = []
}

struct TransactionState: Equatable {
    var transactions: [C2CTransfer] = []
    var pendingTransfer: TransferForm?
    var error: DXTransactionError?
    var transferSuccess: Bool = false
}

// Projectors

let AppStateProjector: DXStateProjector<AppState, AppState> = { $0 }

let UserStateProjector: DXStateProjector<AppState, UserState> = (\.user)

let CardStateProjector: DXStateProjector<AppState, CardState> = (\.card)

let TransactionStateProjector: DXStateProjector<AppState, TransactionState> = (\.transaction)
