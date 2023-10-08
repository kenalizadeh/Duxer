//
//  ViewController.swift
//  DuxerExample
//
//  Created by Kenan Alizadeh
//

import UIKit
import Duxer
import Swild

class ViewController<VState: State>: DXVC<VState> {

    let store: Store = AppDelegate.shared.store

    override func viewDidLoad() {
        super.viewDidLoad()

        self.setupStateSubscription(projector: VState.projection(from:))
    }

    func setupStateSubscription(projector: @escaping (AppState) -> VState) {

        super.setupStateSubscription(store: self.store, projector: projector)
    }
}
