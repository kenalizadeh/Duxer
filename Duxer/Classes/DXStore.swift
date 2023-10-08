//
//  DXStore.swift
//  Duxer
//
//  Created by Kenan Alizadeh on 11.09.22.
//

import Foundation
import Combine

public class DXStore<State: DXState>: ObservableObject {
    private let _reducer: DXReducer<State>
    private let _middlewares: [DXMiddleware<State>]
    private let _queue = DispatchQueue(label: "Store.Queue", qos: .userInitiated)
    private var _subscriptions: Set<AnyCancellable> = []
    private let _actionSubject: PassthroughSubject<DXAction, Never> = .init()

    @Published
    public private(set) var state: State

    public init(
        initial: State,
        reducer: @escaping DXReducer<State>,
        middlewares: [DXMiddleware<State>] = []
    ) {
        self.state = initial
        self._reducer = reducer
        self._middlewares = middlewares

        self._setupActionSubscription()
    }

    public func dispatch(_ action: DXAction) {
        self._queue.async {
            self._actionSubject.send(action)
        }
    }

    private func _dispatch(_ action: DXAction) {
        let newState = self._reducer(state, action)

        self.state = newState
    }

    private func _setupActionSubscription() {
        self._middlewares.reduce(self._actionSubject.eraseToAnyPublisher()) { partialResult, middleware in
            partialResult
                .flatMap { middleware(self.dispatch, self.state, $0) }
                .eraseToAnyPublisher()
        }
        .receive(on: DispatchQueue.main)
        .sink(receiveValue: self._dispatch)
        .store(in: &self._subscriptions)
    }

    public func projection<ProjectedState: DXState>(_ projector: @escaping DXStateProjector<State, ProjectedState>) -> AnyPublisher<ProjectedState, Never> where ProjectedState: Equatable {

        self.$state
            .map(projector)
            .removeDuplicates()
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
}
