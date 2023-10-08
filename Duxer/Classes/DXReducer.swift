//
//  DXReducer.swift
//  Duxer
//
//  Created by Kenan Alizadeh on 11.09.22.
//

import Foundation

public typealias DXReducer<State: DXState> = (State, DXAction) -> State
