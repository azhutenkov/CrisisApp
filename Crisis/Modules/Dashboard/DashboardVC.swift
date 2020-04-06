//
//  DashboardViewController.swift
//  Crisis
//
//  Created by Alexey Zhutenkov on 09/03/2020.
//  Copyright © 2020 Strange. All rights reserved.
//

import UIKit
import CoreHaptics
import AVKit

final class DashboardVC: UIViewController, UITableViewDelegate, UITableViewDataSource {

	lazy private(set) var dashboardView: DashboardView = DashboardView()
	var viewModel: DashboardVMProtocol? {
		didSet {
			reloadData()
		}
	}

	override func loadView() {
		view = dashboardView
	}

	override func viewDidLoad() {
		super.viewDidLoad()
		setupTableView()
		dashboardView.refreshControl.addTarget(self, action: #selector(fetchData), for: .valueChanged)
	}

	func reloadData() {
		dashboardView.tableView.reloadData()
	}

	private func setupTableView() {
		let tableView = dashboardView.tableView
		tableView.delegate = self
		tableView.dataSource = self
		tableView.registerReusable(cellClass: CurrencyCell.self)
		tableView.registerReusable(cellClass: RelaxButtonCell.self)
	}

	func startAnimation() {
		dashboardView.refreshControl.beginRefreshing()
	}

	func stopAnimation() {
		dashboardView.refreshControl.endRefreshing()
	}

	@objc private func fetchData() {
		viewModel?.fetchRates()
	}

	// MARK: - UITableViewDataSource

	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return viewModel?.countOfItems ?? 0
	}

	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

		guard let itemType = viewModel?.itemType(atIndex: indexPath.row) else { return UITableViewCell() }

		switch itemType {
		case .currency:
			guard let displayModel = viewModel?.displayModel(atIndex: indexPath.row) else { return UITableViewCell() }
			let cell = tableView.dequeueReusableCell(withClass: CurrencyCell.self, for: indexPath)
			cell.logoImageView.image = displayModel.logo
			cell.titleLabel.text = displayModel.title
			cell.subtitleLabel.text = displayModel.value
			return cell
			
		case .button:
			let cell = tableView.dequeueReusableCell(withClass: RelaxButtonCell.self, for: indexPath)
			cell.setSelected(viewModel?.isEnabledFunnyMode ?? false, animated: false)
			return cell
		}
	}

	// MARK: - UITableViewDelegate

	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		guard let viewModel = self.viewModel else { return }

		// Если это кнопка то логика вкл/выкл звука
		if case .button = viewModel.itemType(atIndex: indexPath.row) {
			if !viewModel.isEnabledFunnyMode {
				viewModel.startFunnyMode()
			} else {
				viewModel.stopFunnyMode()
				tableView.deselectRow(at: indexPath, animated: false)
			}
		} else {
			// Событие выбора валюты
			tableView.deselectRow(at: indexPath, animated: false)
			viewModel.selectItem(atIndex: indexPath.row)
		}
	}

	func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
		if case .button = viewModel?.itemType(atIndex: indexPath.row) {
			viewModel?.stopFunnyMode()
		}
	}
}
