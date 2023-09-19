//
//  Middleware.swift
//  IMDbSwiftUIDemo
//
//  Created by Kenan Alizadeh on 11.09.22.
//

import Foundation
import Combine

public typealias Middleware<State> = (@escaping ActionDispatch, State, Action) -> AnyPublisher<Action, Never>

public func createThunkMiddleware<State>() -> Middleware<State> {
    { dispatch, state, action in
        if let action = action as? Thunk<State> {
            action.body(dispatch, state)
            return Empty().eraseToAnyPublisher()
        }

        return Just(action).eraseToAnyPublisher()
    }
}
