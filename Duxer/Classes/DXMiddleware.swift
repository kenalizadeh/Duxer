//
//  DXMiddleware.swift
//  Duxer
//
//  Created by Kenan Alizadeh
//

import Foundation
import Combine

public typealias StateProvider<State> = () -> State

public typealias DXMiddleware<State: DXState> = (@escaping DXActionDispatch, StateProvider<State>, DXAction) -> DXAction?

public func createThunkMiddleware<State: DXState>() -> DXMiddleware<State> {
    { dispatch, getState, action in
        if let action = action as? DXThunk<State> {
            action.body(dispatch, getState())
            return nil
        }

        return action
    }
}
