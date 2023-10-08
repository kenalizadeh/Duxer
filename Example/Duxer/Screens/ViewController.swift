//
//  ViewController.swift
//  DuxerExample
//
//  Created by Kenan Alizadeh on 23.04.23.
//

import UIKit
import Duxer
import Swild

class ViewController<State: DXState>: DXVC<State> {

    let store: Store = AppDelegate.shared.store

    func setupStateSubscription(projector: @escaping (AppState) -> State) {

        super.setupStateSubscription(store: self.store, projector: projector)
    }
}
