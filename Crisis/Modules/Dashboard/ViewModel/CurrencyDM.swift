//
//  CurrencyDM.swift
//  Crisis
//
//  Created by Alexey Zhutenkov on 09/03/2020.
//  Copyright © 2020 Strange. All rights reserved.
//

import UIKit

struct CurrencyDM: CurrencyDMProtocol {

	let currency: CurrencyType
	let price: Double

	init(currency: CurrencyType, price: Double) {
		self.currency = currency
		self.price = price
	}

	var value: String {
		return String(format: "%.2f", price).replacingOccurrences(of: ".", with: ",")
	}

	var logo: UIImage? {
		return UIImage(named: currency.rawValue)
	}

	var title: String {
		switch currency {
		case .USD:
			return "Американский доллар"
		case .RUB:
			return "Российский рубль"
		case .UAH:
			return "Українська гривня"
		case .KZT:
			return "Қазақстан теңгесі"
		case .BYN:
			return "Беларускі рубель"
		case .AMD:
			return "Հայկական դրամ"
		case .AZN:
			return "Azərbaycan manatı"
		case .TJS:
			return "Сомониро ташкил медиҳад"
		case .UZS:
			return "O‘zbek so‘mi"
		case .KGS:
			return "Кыргызстандын сом"
		case .MDL:
			return "Leu moldovenesc"
		}
	}

	var code: String {
		switch currency {
		case .USD:
			return "$"
		case .RUB:
			return "₽"
		case .UAH:
			return "₴"
		case .KZT:
			return "₸"
		case .BYN:
			return "Br"
		case .AMD:
			return "֏"
		case .AZN:
			return "₼"
		case .TJS:
			return "с."
		case .UZS:
			return "сўм"
		case .KGS:
			return "с"
		case .MDL:
			return "L"
		}
	}

	var order: Int {
		switch currency {
		case .USD:
			return -1
		case .RUB:
			return 0
		case .UAH:
			return 1
		case .KZT:
			return 2
		case .BYN:
			return 3
		case .AMD:
			return 4
		case .AZN:
			return 5
		case .TJS:
			return 6
		case .UZS:
			return 7
		case .KGS:
			return 8
		case .MDL:
			return 9
		}
	}
}
