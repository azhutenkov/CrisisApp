//
//  RelaxButtonCell.swift
//  Crisis
//
//  Created by Alexey Zhutenkov on 12/03/2020.
//  Copyright © 2020 Strange. All rights reserved.
//

import UIKit

final class RelaxButtonCell: UITableViewCell {
	
	lazy private(set) var logoImageView: UIImageView = UIImageView()
	lazy private(set) var titleLabel: UILabel = UILabel()
	var normalBackgroundColor: UIColor = ColorAssets.relaxButtonBackground
	var hoverBackgroundColor: UIColor = ColorAssets.relaxButtonPressedBackground
	var normalTitle: String = LocalizedStrings.Dashboard.buttonNormalTitle.localized
	var selectedTitle: String = LocalizedStrings.Dashboard.buttonPressedTitle.localized
	
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

	override func setSelected(_ selected: Bool, animated: Bool) {
		super.setSelected(selected, animated: animated)

		if selected {
			titleLabel.text = selectedTitle
		} else {
			titleLabel.text = normalTitle
		}
	}

	override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
		super.touchesBegan(touches, with: event)
		buttonPressed()
	}

	override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
		super.touchesEnded(touches, with: event)
		buttonUnpressed()
	}

	override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
		super.touchesCancelled(touches, with: event)
		buttonUnpressed()
	}

	private func setupUI() {
		selectionStyle = .none
		contentView.backgroundColor = .clear
		backgroundColor = .clear

		contentView.addSubview(containerView)
		contentView.addSubview(logoImageView)
		contentView.addSubview(titleLabel)

		containerView.backgroundColor = ColorAssets.relaxButtonBackground

		containerView.snp.makeConstraints { make in
			make.right.left.equalToSuperview()
			make.height.equalTo(60.0)
			make.top.equalToSuperview().offset(18.0)
			make.bottom.equalToSuperview().offset(-8.0)
		}

		logoImageView.snp.makeConstraints { make in
			make.left.equalToSuperview().offset(18.0)
			make.bottom.equalToSuperview()
		}

		titleLabel.snp.makeConstraints { make in
			make.left.equalTo(logoImageView.snp.right).offset(14.0)
			make.right.equalTo(containerView.snp.right).offset(-8.0)
			make.centerY.equalTo(containerView.snp.centerY)
		}

		logoImageView.image = UIImage(named: "buttonCat")
		logoImageView.contentMode = .center
		logoImageView.setContentHuggingPriority(.required, for: .horizontal)
		logoImageView.setContentHuggingPriority(.required, for: .vertical)

		titleLabel.textAlignment = .left
		titleLabel.font = UIFont.systemFont(ofSize: 16.0)
		titleLabel.textColor = ColorAssets.relaxButtonTitle
	}

	private func buttonPressed() {
		containerView.backgroundColor = hoverBackgroundColor
	}

	private func buttonUnpressed() {
		containerView.backgroundColor = normalBackgroundColor
	}
}
