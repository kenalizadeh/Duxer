//
//  DXMiddleware.swift
//  Duxer
//
//  Created by Kenan Alizadeh on 11.09.22.
//

import Foundation
import Combine

public typealias DXMiddleware<State: DXState> = (@escaping DXActionDispatch, State, DXAction) -> AnyPublisher<DXAction, Never>

public func createThunkMiddleware<State: DXState>() -> DXMiddleware<State> {
    { dispatch, state, action in
        if let action = action as? DXThunk<State> {
            action.body(dispatch, state)
            return Empty().eraseToAnyPublisher()
        }

        return Just(action).eraseToAnyPublisher()
    }
}
