//
//  UIViewController+Transitions.swift
//  carsharing
//
//  Created by Alexey Zhutenkov on 01/03/2020.
//

import UIKit

protocol Transiting {
	func removeFromParentTransition(
		animated: Bool,
		duration: TimeInterval,
		options: UIView.AnimationOptions,
		completion: VoidCallback?
	)
}

extension UIViewController: Transiting {

	func removeFromParentTransition(
		animated: Bool,
		duration: TimeInterval,
		options: UIView.AnimationOptions,
		completion: VoidCallback?
	) {
		willMove(toParent: nil)
		if let parentView = parent?.view, animated == true {
			UIView.transition(
				with: parentView,
				duration: duration,
				options: options,
				animations: { [weak self] in
					self?.view.isHidden = true
				}
			) { [weak self] finished in
				if let strongSelf = self {
					strongSelf.view.removeFromSuperview()
					strongSelf.removeFromParent()
				}
				completion?()
			}
		} else {
			view.isHidden = true
			view.removeFromSuperview()
			removeFromParent()
			completion?()
		}
	}
}
