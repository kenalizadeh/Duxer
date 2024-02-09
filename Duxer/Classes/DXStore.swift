//
//  DXStore.swift
//  Duxer
//
//  Created by Kenan Alizadeh
//

import Foundation
import Combine

public class DXStore<State: DXState>: ObservableObject {
    private let _reducer: DXReducer<State>
    private let _middlewares: [DXMiddleware<State>]
    private var _subscriptions: Set<AnyCancellable> = []
    private let _actionSubject: PassthroughSubject<DXAction, Never> = .init()
    private let _queue = DispatchQueue(label: "DXStore.StateUpdateQueue", qos: .userInteractive)

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

    private func _reduce(_ action: DXAction) {
        self.state = self._reducer(self.state, action)
    }

    private func getState() -> State {
        self.state
    }

    private func _setupActionSubscription() {
        self._middlewares.reduce(self._actionSubject.eraseToAnyPublisher()) { partialResult, middleware in
            partialResult
                .compactMap { middleware(self.dispatch, self.getState, $0) }
                .flatMap { Just($0).eraseToAnyPublisher() }
                .eraseToAnyPublisher()
        }
        .receive(on: DispatchQueue.main)
        .sink(receiveValue: self._reduce)
        .store(in: &self._subscriptions)
    }

    public func projection<ProjectedState: DXState>(_ projector: @escaping DXStateProjector<State, ProjectedState>) -> AnyPublisher<ProjectedState, Never> where ProjectedState: Equatable {
        self.$state
            .map(projector)
            .removeDuplicates()
            .eraseToAnyPublisher()
    }
}
