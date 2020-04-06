//
//  CalculatorItemVM.swift
//  Crisis
//
//  Created by Alexey Zhutenkov on 12/03/2020.
//  Copyright © 2020 Strange. All rights reserved.
//

import Foundation

class CalculatorItemVM: CalculatorItemVMProtocol {
	var value: Double
	var currency: Currency
	var updateCallback: UpdateCallback<CalculatorItemVMProtocol>?

	init(value: Double, currency: Currency) {
		self.value = value
		self.currency = currency
	}

	var displayModel: CurrencyDMProtocol {
		return CurrencyDM(currency: currency.type, price: value)
	}
}
