//
//  ViewController.swift
//  DuxerExample
//
//  Created by Kenan Alizadeh on 23.04.23.
//

import UIKit
import Combine
import WrapperCell
import Swild

class ViewController<State: Equatable>: UIViewController {

    typealias StateProjector = (DXAppState) -> State

    let store: DXStore = AppDelegate.shared.store

    var cancellables: Set<AnyCancellable> = .init()

    var stateProjector: StateProjector? { nil }

    @available(*, unavailable)
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }

    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nil, bundle: nil)
        self.view.backgroundColor = .systemBackground

        self.store
            .$state
            .subscribe(on: DispatchQueue.global())
            .compactMap({ [weak self] state in
                guard let state = self?.stateProjector?(state)
                else {
                    print(":DUXER: `stateProjector` implementation is missing | State changes will not be forwarded to [\(Self.self)].")
                    return nil
                }

                return state
            })
            .removeDuplicates()
            .receive(on: DispatchQueue.main)
            .sink(receiveValue: { [weak self] state in
                self?.render(state: state)
            })
            .store(in: &self.cancellables)
    }

    func render(state: State) {}
}
