//
//  Thunks.swift
//  DuxerExample
//
//  Created by Kenan Alizadeh
//

import Combine
import Duxer

func transactionThunk(data: C2CTransfer) -> DXThunk<AppState> {
    .init(identifier: #function) { dispatch, state in
        let delay: TimeInterval = .random(in: 0.2 ... 2)

        DispatchQueue.main.asyncAfter(deadline: .now() + delay) {

            if data.sender.balance > data.amount {
                dispatch(CardAction.updateCardBalance(cardID: data.sender.id, balance: data.sender.balance - data.amount))
                dispatch(CardAction.updateCardBalance(cardID: data.recipient.id, balance: data.recipient.balance + data.amount))
                dispatch(TransferAction.transfer(data))
                dispatch(TransferAction.reset)
            } else {
                dispatch(TransferAction.error(DXTransactionError.insufficientAmount))
            }
        }
    }
}
