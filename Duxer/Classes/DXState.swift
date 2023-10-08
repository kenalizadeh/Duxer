//
//  DXState.swift
//  Duxer
//
//  Created by Kenan Alizadeh
//

import Foundation

public typealias DXState = Equatable

public typealias DXStateProjector<State: DXState, ProjectedState: DXState> = (State) -> ProjectedState
