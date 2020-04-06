//
//  FeedbackEffect+Player.swift
//  Crisis
//
//  Created by Alexey Zhutenkov on 12/03/2020.
//  Copyright © 2020 Strange. All rights reserved.
//

import Foundation

extension FeedbackEffect {
	
	public static func stopSound() {
		FeedbackEffect.player.removeAllItems()
	}
}
