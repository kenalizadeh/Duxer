//
//  DXViewController.swift
//  Duxer
//
//  Created by Kenan Alizadeh on 07.10.23.
//

import UIKit
import Combine

open class DXViewController<ProjectedState: DXState>: UIViewController {

    open var cancellables: Set<AnyCancellable> = .init()

    open func setupStateSubscription<AppState: DXState>(store: DXStore<AppState>, projector: @escaping DXStateProjector<AppState, ProjectedState>) {

        store
            .projection(projector)
            .sink(receiveValue: { [weak self] state in
                self?.render(state: state)
            })
            .store(in: &self.cancellables)
    }

    open func render(state: ProjectedState) {}
}

public typealias DXVC = DXViewController 
