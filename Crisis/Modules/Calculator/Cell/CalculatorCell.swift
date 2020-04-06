//
//  CalculatorCell.swift
//  Crisis
//
//  Created by Alexey Zhutenkov on 12/03/2020.
//  Copyright © 2020 Strange. All rights reserved.
//

import UIKit
import SnapKit

final class CalculatorCell: UITableViewCell, UITextFieldDelegate {

	let inputTextField: UITextField = UITextField()
	let currencyLabel: UILabel = UILabel()
	private let containerView: UIView = UIView()

	var viewModel: CalculatorItemVMProtocol? {
		didSet {
			guard let vm = viewModel else { return }
			configure(vm)
		}
	}

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

	override func becomeFirstResponder() -> Bool {
		inputTextField.becomeFirstResponder()
		return super.becomeFirstResponder()
	}

	private func setupUI() {
		selectionStyle = .none
		contentView.backgroundColor = .clear
		backgroundColor = .clear

		contentView.addSubview(containerView)
		containerView.addSubview(inputTextField)
		inputTextField.rightView = currencyLabel
		containerView.backgroundColor = ColorAssets.currenciesBackground

		containerView.snp.makeConstraints { make in
			make.right.left.equalToSuperview()
			make.height.equalTo(60.0)
			make.top.equalToSuperview().offset(4.0)
			make.bottom.equalToSuperview().offset(-4.0)
		}

		currencyLabel.snp.makeConstraints { make in
			make.height.width.equalTo(44.0)
		}

		inputTextField.snp.makeConstraints { make in
			make.left.equalToSuperview().offset(18.0)
			make.right.equalToSuperview().offset(-18.0)
			make.top.equalToSuperview().offset(18.0)
			make.bottom.equalToSuperview().offset(-18.0)
		}

		inputTextField.font = UIFont.systemFont(ofSize: 24.0)
		inputTextField.textAlignment = .center
		inputTextField.textColor = ColorAssets.text
		inputTextField.rightViewMode = .always
		inputTextField.keyboardType = .decimalPad
		inputTextField.delegate = self

		currencyLabel.font = UIFont.systemFont(ofSize: 24.0)
		currencyLabel.textAlignment = .center
		currencyLabel.textColor = ColorAssets.currencyTitle

		let shadowView = UIView()
		shadowView.backgroundColor = .clear
		containerView.addSubview(shadowView)

		shadowView.snp.makeConstraints { make in
			make.top.right.bottom.left.equalToSuperview()
		}

		inputTextField.addTarget(self, action: #selector(textFieldEditingChanged), for: .editingChanged)
	}

	@objc private func textFieldEditingChanged(_ textField: UITextField) {
		guard var text = textField.text, let vm = viewModel else { return }

		defer {
			vm.value = Double(text.replacingOccurrences(of: ",", with: ".")) ?? 0
			vm.updateCallback?(vm)
		}

		if text.first == "." {
			text = ""
			textField.text = text
		}

		if text.contains(".") {
			text = text.replacingOccurrences(of: ".", with: ",")
			textField.text = text
		}

		if text.count == 2, text.first == "0" && text.last != "," {
			text = String(text.dropFirst())
			textField.text = text
			return
		}
	}

	private func configure(_ vm: CalculatorItemVMProtocol) {
		let dm = vm.displayModel
		inputTextField.text = dm.value
		currencyLabel.text = dm.code
	}

	// MARK: - UITextFieldDelegate

	func textFieldDidBeginEditing(_ textField: UITextField) {
		textField.text = "0"
		textField.setNeedsLayout()
		textField.layoutIfNeeded()
	}

	func textFieldDidEndEditing(_ textField: UITextField) {
		if let text = textField.text, text.isEmpty {
			textField.text = "0"
		}
	}

	func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
		let currentText = textField.text ?? ""
		guard let stringRange = Range(range, in: currentText) else { return false }
		let updatedText = currentText.replacingCharacters(in: stringRange, with: string)
		return updatedText.count <= 9
	}
}


