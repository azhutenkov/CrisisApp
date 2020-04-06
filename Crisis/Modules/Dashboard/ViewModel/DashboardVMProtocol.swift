//
//  DashboardVMProtocol.swift
//  Crisis
//
//  Created by Alexey Zhutenkov on 09/03/2020.
//  Copyright © 2020 Strange. All rights reserved.
//

import Foundation

enum DashboardItemType {
	case currency
	case button
}

protocol DashboardVMProtocol: DashboardFunnyModeVMProtocol {

	var countOfItems: Int { get }
	func itemType(atIndex index: Int) -> DashboardItemType
	func displayModel(atIndex index: Int) -> CurrencyDMProtocol
	func selectItem(atIndex index: Int)

	var updateCallback: ResultCallback<Void>? { get set }
	var loadDataCallback: VoidCallback? { get set }
	var onPressed: ((_ general: Currency, _ secondary: Currency) -> Void)? { get set }

	func fetchRates()
}

protocol DashboardFunnyModeVMProtocol {
	var isEnabledFunnyMode: Bool { get }
	func startFunnyMode()
	func stopFunnyMode()
}
