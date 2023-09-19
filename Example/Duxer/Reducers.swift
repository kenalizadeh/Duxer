//
//  Reducers.swift
//  DuxerExample
//
//  Created by 004230 on 23.04.23.
//

import Duxer

let rootReducer: Reducer<DXAppState> = { state, action in
    DXAppState(
        user: userReducer(state.user, action),
        card: cardReducer(state.card, action),
        transaction: transactionReducer(state.transaction, action)
    )
}

let userReducer: Reducer<DXUserState> = { state, action in

    if case let DXAction.print(text) = action {
        print(Date(), text)
    }

    guard case let DXAction.user(action) = action else { return state }

    var state = state

    switch action {
    case let .register(userData):
        state.userData = userData
    }

    return state
}

let cardReducer: Reducer<DXCardState> = { state, action in

    guard case let DXAction.card(action) = action else { return state }

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

let transactionReducer: Reducer<DXTransactionState> = { state, action in

    guard case let DXAction.transfer(action) = action else { return state }

    var state = state

    switch action {
    case let .pendingTransferFormUpdate(transferForm):
        state.pendingTransfer = transferForm

    case let .transfer(transfer):
        state.transactions.append(transfer)
    }

    return state
}
