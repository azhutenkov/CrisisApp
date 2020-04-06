//
//  LaunchVM.swift
//  Crisis
//
//  Created by Alexey Zhutenkov on 09/03/2020.
//  Copyright © 2020 Strange. All rights reserved.
//

import Foundation

struct LaunchVM: LaunchVMProtocol {
	private static let imageKey: String = "kLaunchImageIndex"

	var displayModel: LaunchDMProtocol
	var closeAction: VoidCallback?

	init() {
		var imageIndex: Int = UserDefaults.standard.integer(forKey: LaunchVM.imageKey)
		let maxIndex: Int = 4
		if imageIndex > maxIndex {
			imageIndex = 0
		}
		let imageName = "launch_\(imageIndex)"

		imageIndex += 1
		UserDefaults.standard.set(imageIndex, forKey: LaunchVM.imageKey)

		displayModel = LaunchDM(imageName: imageName)
	}
}
