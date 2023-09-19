//
//  Thunk.swift
//  IMDbSwiftUIDemo
//
//  Created by Kenan Alizadeh on 11.09.22.
//

import Combine
import Foundation

public struct Thunk<State>: Action {
    internal let body: (@escaping ActionDispatch, State) -> Void

    public init(_ body: @escaping (@escaping ActionDispatch, State) -> Void) {
        self.body = body
    }
}
