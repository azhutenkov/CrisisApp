//
//  LaunchVMProtocol.swift
//  Crisis
//
//  Created by Alexey Zhutenkov on 09/03/2020.
//  Copyright © 2020 Strange. All rights reserved.
//

import UIKit

protocol LaunchVMProtocol {
	var displayModel: LaunchDMProtocol { get }
	var closeAction: VoidCallback? { get set }
}
