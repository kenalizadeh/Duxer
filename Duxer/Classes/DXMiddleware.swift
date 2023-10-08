//
//  DXMiddleware.swift
//  Duxer
//
//  Created by Kenan Alizadeh
//

import Foundation
import Combine

public typealias DXMiddleware<State: DXState> = (@escaping DXActionDispatch, State, DXAction) -> DXAction?

public func createThunkMiddleware<State: DXState>() -> DXMiddleware<State> {
    { dispatch, state, action in
        if let action = action as? DXThunk<State> {
            action.body(dispatch, state)
            return nil
        }

        return action
    }
}
