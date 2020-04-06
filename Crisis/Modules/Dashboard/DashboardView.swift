//
//  DashboardView.swift
//  Crisis
//
//  Created by Alexey Zhutenkov on 09/03/2020.
//  Copyright © 2020 Strange. All rights reserved.
//

import UIKit

final class DashboardView: UIView {

	let tableView: UITableView = UITableView(frame: .zero, style: .grouped)
	let refreshControl: UIRefreshControl = UIRefreshControl()

	override init(frame: CGRect) {
		super.init(frame: frame)
		setupUI()
	}

	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	private func setupUI() {
		backgroundColor = ColorAssets.dashboardBackground

		addSubview(tableView)
		tableView.refreshControl = refreshControl

		tableView.backgroundColor = UIColor.clear
		tableView.contentInsetAdjustmentBehavior = .never
		tableView.showsVerticalScrollIndicator = false
		tableView.separatorStyle = .none

		tableView.snp.makeConstraints { make in
			make.top.equalTo(safeAreaLayoutGuide.snp.top)
			make.bottom.equalToSuperview()
			make.left.equalToSuperview().offset(18.0)
			make.right.equalToSuperview().offset(-18.0)
		}
	}
}
