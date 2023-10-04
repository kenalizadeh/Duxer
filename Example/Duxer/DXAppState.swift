//
//  DXAppState.swift
//  DuxerExample
//
//  Created by Kenan Alizadeh on 23.04.23.
//

import Foundation
import Duxer

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
    var error: DXTransactionError?
    var transferSuccess: Bool = false
}
