//
//  Middlewares.swift
//  DuxerExample
//
//  Created by Kenan Alizadeh on 23.04.23.
//

import Combine
import Duxer

let loggerMiddleware: Middleware<DXAppState> = { _, _, action in
    defer { debugPrint(":LOGGER:", Date(), String(describing: action).prefix(100)) }

    return Just(action).eraseToAnyPublisher()
}
