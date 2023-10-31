//
//  DXThunk.swift
//  Duxer
//
//  Created by Kenan Alizadeh
//

import Combine
import Foundation

public struct DXThunk<State: DXState>: DXAction {
    internal let identifier: String?
    internal let body: (@escaping DXActionDispatch, State) -> Void

    public init(identifier: String? = nil, _ body: @escaping (@escaping DXActionDispatch, State) -> Void) {
        self.identifier = identifier
        self.body = body
    }
}

extension DXThunk: CustomStringConvertible {
    public var description: String {
        [String(describing: Self.self), "| ID:", self.identifier ?? "<none>"].joined(separator: " ")
    }
}
