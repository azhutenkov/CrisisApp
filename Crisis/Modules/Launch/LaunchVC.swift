//
//  LaunchVC.swift
//  Crisis
//
//  Created by Alexey Zhutenkov on 09/03/2020.
//  Copyright © 2020 Strange. All rights reserved.
//

import UIKit

final class LaunchVC: UIViewController {

	private enum Constants {
		static let timeout: Double = 2.0
	}

	let launchView: LaunchView = LaunchView(frame: .zero)

	var viewModel: LaunchVMProtocol? {
		didSet {
			reloadData()
		}
	}

	var timer: Timer?

	deinit {
		stopTimerIfNeeded()
	}

	override func loadView() {
		view = launchView
	}

	override func viewDidLoad() {
		super.viewDidLoad()
		reloadData()
		setupTimer()
		setupButtons()
	}

	private func setupButtons() {
		launchView.fullScreenButton.addTarget(self, action: #selector(buttonPressed), for: .touchDown)
		launchView.fullScreenButton.addTarget(self, action: #selector(buttonUnpressed), for: .touchUpInside)
	}

	private func setupTimer() {
		timer = Timer.scheduledTimer(withTimeInterval: Constants.timeout, repeats: false, block: { [weak self] _ in
			self?.stopTimerIfNeeded()
			self?.viewModel?.closeAction?()
		})
	}

	private func stopTimerIfNeeded() {
		if let timer = self.timer, timer.isValid {
			timer.invalidate()
		}
	}

	@objc private func buttonPressed(_ sender: UIButton) {
		stopTimerIfNeeded()
	}

	@objc private func buttonUnpressed(_ sender: UIButton) {
		viewModel?.closeAction?()
	}

	private func reloadData() {
		launchView.imageView.image = viewModel?.displayModel.messageImage
	}
}
