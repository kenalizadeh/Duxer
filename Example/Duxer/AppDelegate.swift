//
//  AppDelegate.swift
//  Duxer
//
//  Created by Kenan Alizadeh
//

import UIKit
import Duxer

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    public private(set) var store = DXStore(
        initial: AppState(),
        reducer: rootReducer,
        middlewares: [
            loggerMiddleware,
            createThunkMiddleware()
        ]
    )

    private var coordinator: NavigationCoordinator = .init()

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

        self.window = UIWindow(frame: UIScreen.main.bounds)
        self.window?.makeKeyAndVisible()
        self.window?.backgroundColor = .systemBackground
        self.window?.rootViewController = UIViewController()

        self.coordinator.setupStateSubscription()

        self.store.dispatch(NavigationAction.launch)

        self.demo()

        return true
    }

    func demo() {

        struct DemoUnit {
            let action: () -> any DXAction
            let delay: TimeInterval
        }

        var card1: Card {
            self.store.state.card.cards.first(where: { $0.id == "1" }) ??
            Card(id: "1", label: "1", number: "4141414141414141", balance: 10, currency: .azn, expirationDate: "10/27", cvv: "420")
        }
        var card2: Card {
            self.store.state.card.cards.first(where: { $0.id == "2" }) ??
            Card(id: "2", label: "2", number: "4242424242424242", balance: 10, currency: .azn, expirationDate: "10/27", cvv: "420")
        }

        let units: [DemoUnit] = [
            .init(action: { registrationThunk(data: .init(firstName: "A", lastName: "B", birthDate: Date(), phoneNumber: "101001010")) }, delay: 0.5),
            .init(action: { CardAction.create(card1) }, delay: 2),
            .init(action: { CardAction.create(card2) }, delay: 2.5),
            .init(action: { transactionThunk(data: .init(sender: card1, recipient: card2, amount: 2, date: .now)) }, delay: 2.5),
            .init(action: { NavigationAction.cardDetails(card: card2) }, delay: 5),
            .init(action: { transactionThunk(data: .init(sender: card2, recipient: card1, amount: 4, date: .now)) }, delay: 5.5),
            .init(action: { NavigationAction.home }, delay: 7.5),
            .init(action: { transactionThunk(data: .init(sender: card1, recipient: card2, amount: 2, date: .now)) }, delay: 8)
        ]

        for unit in units.lazy {
            DispatchQueue.global().asyncAfter(
                deadline: .now() + unit.delay,
                execute: {
                    self.store.dispatch(unit.action())
                }
            )
        }
    }
}

extension AppDelegate {

    static let shared: AppDelegate = UIApplication.shared.delegate as! AppDelegate
}
