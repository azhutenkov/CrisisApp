//
//  CalculatorVC.swift
//  Crisis
//
//  Created by Alexey Zhutenkov on 12/03/2020.
//  Copyright © 2020 Strange. All rights reserved.
//

import UIKit

final class CalculatorVC: UIViewController, UITableViewDataSource, UITableViewDelegate {

	private lazy var calculatorView: CalculatorView = CalculatorView()
	var viewModel: CalculatorVMProtocol? {
		didSet {
			guard let vm = viewModel else { return }
			vm.updateCallback = { [weak self] rows in
				self?.calculatorView.tableView.reloadRows(at: rows, with: .none)
			}
		}
	}

	override func loadView() {
		view = calculatorView
	}

	override func viewDidLoad() {
		super.viewDidLoad()
		setupUI()
	}

	override func viewDidAppear(_ animated: Bool) {
		super.viewDidAppear(animated)
		calculatorView.tableView.visibleCells.first?.becomeFirstResponder()
	}

	private func setupUI() {
		setupTableView()
		let closeBarButtonItem = UIBarButtonItem(
			image: UIImage(named: "closeButton"),
			style: .plain,
			target: self,
			action: #selector(closeButtonClicked)
		)
		navigationItem.rightBarButtonItem = closeBarButtonItem
		title = LocalizedStrings.Calculator.title.localized
	}
	
	private func setupTableView() {
		let tableView = calculatorView.tableView
		tableView.delegate = self
		tableView.dataSource = self
		tableView.registerReusable(cellClass: CalculatorCell.self)
	}

	@objc private func closeButtonClicked() {
		viewModel?.closeCallback?()
	}

	// MARK: - UITableViewDataSource

	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return viewModel?.countOfItems ?? 0
	}

	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		guard let vm = viewModel?.item(atIndex: indexPath.row) else { return UITableViewCell() }
		let cell = tableView.dequeueReusableCell(withClass: CalculatorCell.self, for: indexPath)
		cell.viewModel = vm
		return cell
	}

	// MARK: - UITableViewDelegate

	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		if let cell = tableView.cellForRow(at: indexPath) as? CalculatorCell {
			cell.inputTextField.becomeFirstResponder()
		}
	}
}
