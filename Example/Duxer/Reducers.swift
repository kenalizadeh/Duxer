//
//  Reducers.swift
//  DuxerExample
//
//  Created by Kenan Alizadeh
//

import Duxer

let rootReducer: DXReducer<AppState> = { state, action in
    AppState(
        user: userReducer(state.user, action),
        card: cardReducer(state.card, action),
        transaction: transactionReducer(state.transaction, action)
    )
}

let userReducer: DXReducer<UserState> = { state, action in

    guard let action = action as? UserAction else { return state }

    var state = state

    switch action {
    case let .register(userData):
        state.userData = userData
    }

    return state
}

let cardReducer: DXReducer<CardState> = { state, action in

    guard let action = action as? CardAction else { return state }

    var state = state

    switch action {
    case let .create(card):
        state.cards.append(card)

    case let .delete(card):
        state.cards.removeAll(where: { $0.id == card.id })

    case let .updateCardBalance(cardID, balance):
        guard let cardIndex = state.cards.firstIndex(where: { $0.id == cardID })
        else { break }

        state.cards[cardIndex].balance = balance
    }

    return state
}

let transactionReducer: DXReducer<TransactionState> = { state, action in

    guard let action = action as? TransferAction else { return state }

    var state = state

    switch action {
    case let .pendingTransferFormUpdate(transferForm):
        state.pendingTransfer = transferForm

    case let .transfer(transfer):
        state.transactions.append(transfer)
        state.transferSuccess = true

    case let .error(error):
        state.error = error

    case .reset:
        state.pendingTransfer = nil
        state.error = nil
        state.transferSuccess = false
    }

    return state
}
