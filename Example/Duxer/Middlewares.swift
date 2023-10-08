//
//  Middlewares.swift
//  DuxerExample
//
//  Created by Kenan Alizadeh
//

import Combine
import Duxer

let loggerMiddleware: DXMiddleware<AppState> = { _, _, action in
    defer { debugPrint(":LOGGER:", Date(), String(describing: action).prefix(100)) }

    return Just(action).eraseToAnyPublisher()
}
