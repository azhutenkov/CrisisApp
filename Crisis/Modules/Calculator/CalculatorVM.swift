//
//  CalculatorVM.swift
//  Crisis
//
//  Created by Alexey Zhutenkov on 12/03/2020.
//  Copyright © 2020 Strange. All rights reserved.
//

import Foundation

final class CalculatorVM: CalculatorVMProtocol {

	var generalItemVM: CalculatorItemVMProtocol
	var secondaryItemVM: CalculatorItemVMProtocol
	var updateCallback: UpdateCallback<[IndexPath]>?
	var closeCallback: VoidCallback?

	private lazy var items: [CalculatorItemVMProtocol] = [generalItemVM, secondaryItemVM]

	init(withGeneralCurrency general: Currency, secondaryCurrency: Currency) {
		generalItemVM = CalculatorItemVM(value: 0, currency: general)
		secondaryItemVM = CalculatorItemVM(
			value: generalItemVM.value * secondaryCurrency.rate,
			currency: secondaryCurrency
		)
		setupHandlers()
	}

	var countOfItems: Int {
		return items.count
	}

	func item(atIndex index: Int) -> CalculatorItemVMProtocol {
		return items[index]
	}

	private func setupHandlers() {
		generalItemVM.updateCallback = { [weak self] vm in
			guard let self = self else { return }
			let rate = self.secondaryItemVM.currency.rate
			self.secondaryItemVM.value = vm.value * rate
			self.updateCallback?([IndexPath(row: 1, section: 0)])
		}

		secondaryItemVM.updateCallback = { [weak self] vm in
			guard let self = self else { return }
			let rate = vm.currency.rate
			self.generalItemVM.value = vm.value / rate
			self.updateCallback?([IndexPath(row: 0, section: 0)])
		}
	}
}
