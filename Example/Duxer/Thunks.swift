//
//  Thunks.swift
//  DuxerExample
//
//  Created by Kenan Alizadeh on 24.04.23.
//

import Combine
import Duxer

func transactionThunk(data: C2CTransfer) -> Thunk<DXAppState> {
    .init { dispatch, state in
        let delay: TimeInterval = .random(in: 0.2 ... 2)

        DispatchQueue.main.asyncAfter(deadline: .now() + delay) {

            if data.sender.balance > data.amount {
                dispatch(DXAction.card(.updateCardBalance(cardID: data.sender.id, balance: data.sender.balance - data.amount)))
                dispatch(DXAction.card(.updateCardBalance(cardID: data.recipient.id, balance: data.recipient.balance + data.amount)))
                dispatch(DXAction.transfer(.transfer(data)))
                dispatch(DXAction.transfer(.reset))
            } else {
                dispatch(DXAction.transfer(.error(DXTransactionError.insufficientAmount)))
            }
        }
    }
}
