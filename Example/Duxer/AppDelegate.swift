//
//  AppDelegate.swift
//  Duxer
//
//  Created by 004230 on 09/19/2023.
//  Copyright (c) 2023 004230. All rights reserved.
//

import UIKit
import Duxer

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    public private(set) var store = DXStore(
        initial: DXAppState(),
        reducer: rootReducer,
        middlewares: [
            loggerMiddleware,
            createThunkMiddleware()
        ]
    )

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

        self.window = UIWindow(frame: UIScreen.main.bounds)
        self.window?.makeKeyAndVisible()
        self.window?.backgroundColor = .systemBackground

        let rootViewController = self.store.state.user.isLoggedIn
        ? HomeViewController()
        : RegistrationViewController()

        self.window?.rootViewController = UINavigationController(rootViewController: rootViewController)

        return true
    }
}

extension AppDelegate {

    static let shared: AppDelegate = UIApplication.shared.delegate as! AppDelegate
}
