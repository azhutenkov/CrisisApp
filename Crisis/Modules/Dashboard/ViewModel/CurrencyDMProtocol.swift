//
//  CurrencyDMProtocol.swift
//  Crisis
//
//  Created by Alexey Zhutenkov on 09/03/2020.
//  Copyright © 2020 Strange. All rights reserved.
//

import UIKit

protocol CurrencyDMProtocol {
	var currency: CurrencyType { get }
	var price: Double { get }
	var logo: UIImage? { get }
	var value: String { get }
	var code: String { get }
	var title: String { get }
	var order: Int { get }
}
