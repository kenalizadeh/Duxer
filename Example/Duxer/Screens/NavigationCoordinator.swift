//
//  NavigationCoordinator.swift
//  Duxer_Example
//
//  Created by Kenan Alizadeh on 03.02.24.
//  Copyright © 2024 CocoaPods. All rights reserved.
//

import UIKit
import Combine
import Duxer

final class NavigationCoordinator: NSObject {
    private var cancellable: AnyCancellable?

    public func setupStateSubscription() {

        self.cancellable = AppDelegate.shared.store
            .projection(NavigationState.projection(from:))
            .sink(receiveValue: { [weak self] state in
                self?.handle(state: state)
            })
    }
}

private extension NavigationCoordinator {

    var window: UIWindow? {
        AppDelegate.shared.window
    }

    var store: DXStore<AppState> {
        AppDelegate.shared.store
    }

    var appState: AppState {
        self.store.state
    }

    func handle(state: NavigationState) {
        switch state {
        case .launch:
            // No need to do anything
            break

        case .registration:
            if let rootNavigation = self.window?.rootViewController as? UINavigationController {
                guard !(rootNavigation.topViewController is RegistrationViewController)
                else { return }

                rootNavigation.setViewControllers([RegistrationViewController()], animated: true)
            } else {
                self.window?.rootViewController = UINavigationController(rootViewController: RegistrationViewController())
            }

        case .home:
            if let rootNavigation = self.window?.rootViewController as? UINavigationController {
                guard !(rootNavigation.topViewController is HomeViewController)
                else { return }

                rootNavigation.setViewControllers([HomeViewController()], animated: true)
            } else {
                self.window?.rootViewController = UINavigationController(rootViewController: HomeViewController())
            }

        case let .cardDetails(card):
            if let rootNavigation = self.window?.rootViewController as? UINavigationController {
                guard !(rootNavigation.topViewController is CardDetailViewController)
                else { return }

                rootNavigation.pushViewController(CardDetailViewController(card: card), animated: true)
            } else {
                let rootVC = UINavigationController()
                self.window?.rootViewController = rootVC
                rootVC.setViewControllers([HomeViewController(), CardDetailViewController(card: card)], animated: true)
            }

        case .cardOrder:
            if let rootNavigation = self.window?.rootViewController as? UINavigationController {
                guard !(rootNavigation.topViewController is OrderCardViewController)
                else { return }

                rootNavigation.pushViewController(OrderCardViewController(), animated: true)
            } else {
                let rootVC = UINavigationController()
                self.window?.rootViewController = rootVC
                rootVC.setViewControllers([HomeViewController(), OrderCardViewController()], animated: true)
            }

        case .cardLink:
            if let rootNavigation = self.window?.rootViewController as? UINavigationController {
                guard !(rootNavigation.topViewController is LinkCardViewController)
                else { return }

                rootNavigation.pushViewController(LinkCardViewController(), animated: true)
            } else {
                let rootVC = UINavigationController()
                self.window?.rootViewController = rootVC
                rootVC.setViewControllers([HomeViewController(), LinkCardViewController()], animated: true)
            }

        case let .transfer(card):
            if let rootNavigation = self.window?.rootViewController as? UINavigationController {
                guard !(rootNavigation.topViewController is TransferViewController)
                else { return }

                rootNavigation.pushViewController(TransferViewController(card: card), animated: true)
            } else {
                let rootVC = UINavigationController()
                self.window?.rootViewController = rootVC
                rootVC.setViewControllers([HomeViewController(), CardDetailViewController(card: card), TransferViewController(card: card)], animated: true)
            }
        }
    }
}
