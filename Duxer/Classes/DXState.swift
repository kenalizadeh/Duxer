//
//  DXState.swift
//  Duxer
//
//  Created by Kenan Alizadeh on 08.10.23.
//

import Foundation

public typealias DXState = Equatable

public typealias DXStateProjector<State: DXState, ProjectedState: DXState> = (State) -> ProjectedState
