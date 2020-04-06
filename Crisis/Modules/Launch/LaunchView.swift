//
//  LaunchView.swift
//  Crisis
//
//  Created by Alexey Zhutenkov on 09/03/2020.
//  Copyright © 2020 Strange. All rights reserved.
//

import UIKit

final class LaunchView: UIView {

	let imageView: UIImageView = UIImageView()
	let fullScreenButton: UIButton = UIButton()

	override init(frame: CGRect) {
		super.init(frame: frame)
		setupUI()
	}

	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	private func setupUI() {
		addSubview(imageView)
		addSubview(fullScreenButton)
		backgroundColor = ColorAssets.launchBackground

		imageView.snp.makeConstraints { make in
			make.center.equalToSuperview()
		}

		fullScreenButton.snp.makeConstraints { make in
			make.top.right.bottom.left.equalToSuperview()
		}
	}
}
