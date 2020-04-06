//
//  AddChildRouting.swift
//  carsharing
//
//  Created by Alexey Zhutenkov on 01/03/2020.
//

import UIKit
import SnapKit

protocol AddChildRouting {

	func addChild(
		childController: UIViewController,
		toParentController parentController: UIViewController
	)

	func addChild(
		childController: UIViewController,
		toParentController parentController: UIViewController,
		childViewHandler: ((UIView) -> Void)?
	)

	func replaceChild(viewController: UIViewController, to parentViewController: UIViewController)
	func replaceChild(viewController: UIViewController, to parentViewController: UIViewController, options: UIView.AnimationOptions)
}

extension AddChildRouting {

	func addChild(childController: UIViewController, toParentController parentController: UIViewController) {

		addChild(
			childController: childController,
			toParentController: parentController,
			childViewHandler: { [weak parentController] childView in
				guard let parentView = parentController?.view else { return }
				parentView.insertSubview(childController.view, at: 0)
				childView.frame = parentView.bounds
				childView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
			}
		)
	}

	func addChild(childController: UIViewController,
				  toParentController parentController: UIViewController,
				  childViewHandler: ((UIView) -> Void)?) {
		parentController.addChild(childController)
		
		childViewHandler?(childController.view)
		
		childController.didMove(toParent: parentController)
	}

	func replaceChild(viewController: UIViewController, to parentViewController: UIViewController) {
		replaceChild(viewController: viewController, to: parentViewController, options: [.curveEaseInOut, .transitionFlipFromLeft])
	}

	func replaceChild(
		viewController: UIViewController,
		to parentViewController: UIViewController,
		options: UIView.AnimationOptions
	) {

		let oldVC = parentViewController.children.first
		parentViewController.addChild(viewController)
		
		parentViewController.view.insertSubview(viewController.view, at: 0)
		viewController.view.snp.makeConstraints { make in
			make.edges.equalToSuperview()
		}
		
		oldVC?.removeFromParentTransition(
			animated: true,
			duration: 0.35,
			options: options
		) {
			debugPrint("replaceChild animation did finish")
		}
	}
}
