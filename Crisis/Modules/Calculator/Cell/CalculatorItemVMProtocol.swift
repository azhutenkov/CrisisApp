//
//  CalculatorItemVMProtocol.swift
//  Crisis
//
//  Created by Alexey Zhutenkov on 12/03/2020.
//  Copyright © 2020 Strange. All rights reserved.
//

import Foundation

protocol CalculatorItemVMProtocol: AnyObject {
	var value: Double { get set }
	var currency: Currency { get set }
	var updateCallback: UpdateCallback<CalculatorItemVMProtocol>? { get set }
	var displayModel: CurrencyDMProtocol { get }
}
