//
//  DXViewModel.swift
//  Duxer
//
//  Created by Kenan Alizadeh
//

import Foundation
import Combine

open class DXViewModel {
    open var cancellables: Set<AnyCancellable> = .init()

    public init() {}

    open func setupStateSubscription<AppState: DXState, ProjectedState: DXState>(store: DXStore<AppState>, projector: @escaping DXStateProjector<AppState, ProjectedState>, stateHandler: @escaping (ProjectedState) -> Void) {

        store
            .projection(projector)
            .sink(receiveValue: stateHandler)
            .store(in: &self.cancellables)
    }
}

public typealias DXVM = DXViewModel
