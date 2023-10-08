//
//  DXThunk.swift
//  Duxer
//
//  Created by Kenan Alizadeh on 11.09.22.
//

import Combine
import Foundation

public struct DXThunk<State: DXState>: DXAction {
    internal let body: (@escaping DXActionDispatch, State) -> Void

    public init(_ body: @escaping (@escaping DXActionDispatch, State) -> Void) {
        self.body = body
    }
}
