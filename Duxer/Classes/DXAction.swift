//
//  DXAction.swift
//  Duxer
//
//  Created by Kenan Alizadeh on 11.09.22.
//

import Foundation

public protocol DXAction {}

public typealias DXActionDispatch = (DXAction) -> ()
