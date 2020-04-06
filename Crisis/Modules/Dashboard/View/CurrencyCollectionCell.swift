//
//  CurrencyCollectionCell.swift
//  Crisis
//
//  Created by Alexey Zhutenkov on 09/03/2020.
//  Copyright © 2020 Strange. All rights reserved.
//

import UIKit

final class CurrencyCollectionCell: UICollectionViewCell {

	lazy private(set) var logoImageView: UIImageView = UIImageView()
	lazy private(set) var titleLabel: UILabel = UILabel()
	lazy private(set) var subtitleLabel: UILabel = UILabel()

	lazy private var containerView: UIView = UIView()

	override init(frame: CGRect) {
		super.init(frame: frame)
		setupUI()
	}

	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	private func setupUI() {
		backgroundColor = UIColor.clear
		contentView.backgroundColor = ColorAssets.currenciesBackground
		contentView.layer.cornerRadius = 10.0

		contentView.addSubview(containerView)
		containerView.addSubview(logoImageView)
		containerView.addSubview(titleLabel)
		containerView.addSubview(subtitleLabel)

		containerView.backgroundColor = UIColor.clear
		containerView.snp.makeConstraints { make in
			make.center.equalToSuperview()
		}

		logoImageView.snp.makeConstraints { make in
			make.top.equalToSuperview()
			make.centerX.equalToSuperview()
			make.height.width.equalTo(45.0)
		}

		titleLabel.textColor = ColorAssets.text
		titleLabel.textAlignment = .center
		titleLabel.font = UIFont.systemFont(ofSize: 24.0)
		titleLabel.snp.makeConstraints { make in
			make.top.equalTo(logoImageView.snp.bottom)
			make.left.right.equalToSuperview()
		}

		subtitleLabel.textColor = ColorAssets.text
		subtitleLabel.font = UIFont.systemFont(ofSize: 10.0)
		subtitleLabel.textAlignment = .center
		subtitleLabel.snp.makeConstraints { make in
			make.top.equalTo(titleLabel.snp.bottom).offset(2.0)
			make.left.right.equalToSuperview()
			make.bottom.equalToSuperview()
		}
	}
}
