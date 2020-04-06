//
//  LaunchDM.swift
//  Crisis
//
//  Created by Alexey Zhutenkov on 09/03/2020.
//  Copyright © 2020 Strange. All rights reserved.
//

import UIKit

struct LaunchDM: LaunchDMProtocol {
	var messageImage: UIImage?

	init(imageName: String) {
		messageImage = UIImage(named: imageName)
	}
}
