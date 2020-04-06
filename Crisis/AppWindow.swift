//
//  AppWindow.swift
//  Crisis
//
//  Created by Alexey Zhutenkov on 09/03/2020.
//  Copyright © 2020 Strange. All rights reserved.
//

import UIKit

class AppWindow: UIWindow {
	
	// MARK: Lifecircle
	required init?(coder aDecoder: NSCoder) {
		super.init(coder: aDecoder)
		setupInitialState()
	}

	override init(frame: CGRect) {
		super.init(frame: frame)
		setupInitialState()
	}
	
	/// Initial first states for views
	func setupInitialState() {
		setupLightModeConfigurationIfCan()
	}
	
	// MARK: Private
	private func setupLightModeConfigurationIfCan() {
		#if compiler(>=5.1)
		// Always adopt a light interface style.
		if #available(iOS 13.0, *) {
			overrideUserInterfaceStyle = .light
		}
		#endif
	}

}
