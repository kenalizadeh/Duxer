//
//  Thunks.swift
//  DuxerExample
//
//  Created by 004230 on 24.04.23.
//

import Combine
import Duxer

func demoThunk() -> Thunk<DXAppState> {
    .init { dispatch, state in
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            dispatch(DXAction.print(":LOG: THUNK ACTION AFTER DELAY"))
        }
    }
}
