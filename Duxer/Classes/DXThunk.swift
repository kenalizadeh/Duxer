//
//  DXThunk.swift
//  Duxer
//
//  Created by Kenan Alizadeh
//

import Combine
import Foundation

public struct DXThunk<State: DXState>: DXAction {
    internal let body: (@escaping DXActionDispatch, State) -> Void

    public init(_ body: @escaping (@escaping DXActionDispatch, State) -> Void) {
        self.body = body
    }
}
