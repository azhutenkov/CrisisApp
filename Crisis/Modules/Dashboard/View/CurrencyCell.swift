//
//  CurrencyCell.swift
//  Crisis
//
//  Created by Alexey Zhutenkov on 10/03/2020.
//  Copyright © 2020 Strange. All rights reserved.
//

import UIKit

final class CurrencyCell: UITableViewCell {

	lazy private(set) var logoImageView: UIImageView = UIImageView()
	lazy private(set) var titleLabel: UILabel = UILabel()
	lazy private(set) var subtitleLabel: UILabel = UILabel()

	private let containerView: UIView = UIView()

	override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
		super.init(style: style, reuseIdentifier: reuseIdentifier)
		setupUI()
	}

	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	override func layoutSubviews() {
		super.layoutSubviews()
		containerView.layer.cornerRadius = 10.0
	}

	private func setupUI() {
		selectionStyle = .none
		contentView.backgroundColor = .clear
		backgroundColor = .clear

		contentView.addSubview(containerView)
		containerView.addSubview(logoImageView)
		containerView.addSubview(titleLabel)
		containerView.addSubview(subtitleLabel)

		containerView.backgroundColor = ColorAssets.currenciesBackground

		containerView.snp.makeConstraints { make in
			make.right.left.equalToSuperview()
			make.height.equalTo(60.0)
			make.top.equalToSuperview().offset(4.0)
			make.bottom.equalToSuperview().offset(-4.0)
		}

		logoImageView.snp.makeConstraints { make in
			make.left.equalToSuperview().offset(18.0)
			make.centerY.equalToSuperview()
		}

		titleLabel.snp.makeConstraints { make in
			make.left.equalTo(logoImageView.snp.right).offset(8.0)
			make.centerY.equalToSuperview()
		}

		subtitleLabel.snp.makeConstraints { make in
			make.right.equalToSuperview().offset(-18.0)
			make.left.equalTo(titleLabel.snp.right).offset(2.0)
			make.centerY.equalToSuperview()
		}

		logoImageView.setContentHuggingPriority(.required, for: .horizontal)

		titleLabel.textAlignment = .left
		titleLabel.font = UIFont.systemFont(ofSize: 14.0)
		titleLabel.minimumScaleFactor = 0.5
		titleLabel.textColor = ColorAssets.currencyTitle

		subtitleLabel.textAlignment = .right
		subtitleLabel.setContentCompressionResistancePriority(.defaultHigh, for: .horizontal)
		subtitleLabel.font = UIFont.systemFont(ofSize: 16.0)
		subtitleLabel.textColor = ColorAssets.text
	}
}
