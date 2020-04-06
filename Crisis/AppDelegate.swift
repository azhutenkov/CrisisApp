//
//  AppDelegate.swift
//  Crisis
//
//  Created by Alexey Zhutenkov on 09/03/2020.
//  Copyright © 2020 Strange. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

	var window: UIWindow?
	var coordinator: CoordinatorProtocol?

	func application(
		_ application: UIApplication,
		didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
	) -> Bool {
		let vc = UIViewController()
		window = AppWindow(frame: UIScreen.main.bounds)
		window?.rootViewController = vc
		coordinator = MainCoordinator(transitionHandler: vc)
		coordinator?.start()
		window?.makeKeyAndVisible()
		return true
	}
}
