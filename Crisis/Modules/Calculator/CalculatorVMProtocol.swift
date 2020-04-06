//
//  CalculatorVMProtocol.swift
//  Crisis
//
//  Created by Alexey Zhutenkov on 12/03/2020.
//  Copyright © 2020 Strange. All rights reserved.
//

import Foundation

protocol CalculatorVMProtocol: AnyObject {

	var generalItemVM: CalculatorItemVMProtocol { get set }
	var secondaryItemVM: CalculatorItemVMProtocol { get set }
	var updateCallback: UpdateCallback<[IndexPath]>? { get set }
	var closeCallback: VoidCallback? { get set }

	var countOfItems: Int { get }
	func item(atIndex index: Int) -> CalculatorItemVMProtocol
}
