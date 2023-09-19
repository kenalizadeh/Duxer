//
//  Middlewares.swift
//  DuxerExample
//
//  Created by 004230 on 23.04.23.
//

import Combine
import Duxer

let loggerMiddleware: Middleware<DXAppState> = { _, _, action in
    defer { debugPrint(":LOGGER:", Date(), String(describing: action).prefix(100)) }

    return Just(action).eraseToAnyPublisher()
}
