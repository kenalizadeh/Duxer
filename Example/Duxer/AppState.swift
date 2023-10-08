//
//  AppState.swift
//  DuxerExample
//
//  Created by Kenan Alizadeh
//

import Foundation
import Duxer

protocol State: DXState {
    static func projection(from state: AppState) -> Self
}

extension State where Self == AppState {
    static func projection(from state: AppState) -> Self { state }
}

extension State where Self == UserState {
    static func projection(from state: AppState) -> Self { state.user }
}

extension State where Self == CardState {
    static func projection(from state: AppState) -> Self { state.card }
}

extension State where Self == TransactionState {
    static func projection(from state: AppState) -> Self { state.transaction }
}

struct AppState: State {
    var user: UserState = .init()
    var card: CardState = .init()
    var transaction: TransactionState = .init()
}

struct UserState: State {
    var userData: UserData?

    var isLoggedIn: Bool {
        self.userData.isNotNil
    }
}

struct CardState: State {
    var cards: [Card] = []
}

struct TransactionState: State {
    var transactions: [C2CTransfer] = []
    var pendingTransfer: TransferForm?
    var error: DXTransactionError?
    var transferSuccess: Bool = false
}
