//
//  DXAppState.swift
//  DuxerExample
//
//  Created by 004230 on 23.04.23.
//

import Foundation

struct DXAppState: Equatable {
    var user: DXUserState = .init()
    var card: DXCardState = .init()
    var transaction: DXTransactionState = .init()
}

struct DXUserState: Equatable {
    var userData: UserData?

    var isLoggedIn: Bool {
        self.userData.isNotNil
    }
}

struct DXCardState: Equatable {
    var cards: [Card] = []
}

struct DXTransactionState: Equatable {
    var transactions: [C2CTransfer] = []
    var pendingTransfer: TransferForm?
}
