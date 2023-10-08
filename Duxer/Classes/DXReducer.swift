//
//  DXReducer.swift
//  Duxer
//
//  Created by Kenan Alizadeh
//

import Foundation

public typealias DXReducer<State: DXState> = (State, DXAction) -> State
