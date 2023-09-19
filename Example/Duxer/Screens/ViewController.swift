//
//  ViewController.swift
//  DuxerExample
//
//  Created by 004230 on 23.04.23.
//

import UIKit
import Combine

class ViewController: UIViewController {

    let store: DXStore = AppDelegate.shared.store

    var cancellables: Set<AnyCancellable> = .init()

    @available(*, unavailable)
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }

    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nil, bundle: nil)

        self.view.backgroundColor = .systemBackground

        self.store
            .$state
            .subscribe(on: DispatchQueue.global())
            .receive(on: DispatchQueue.main)
            .sink(receiveValue: self.render(state:))
            .store(in: &self.cancellables)
    }

    func render(state: DXAppState) {}
}