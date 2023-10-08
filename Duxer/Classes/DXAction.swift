//
//  DXAction.swift
//  Duxer
//
//  Created by Kenan Alizadeh
//

import Foundation

public protocol DXAction {}

public typealias DXActionDispatch = (DXAction) -> ()
