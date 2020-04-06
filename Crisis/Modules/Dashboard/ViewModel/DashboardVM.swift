//
//  DashboardVM.swift
//  Crisis
//
//  Created by Alexey Zhutenkov on 09/03/2020.
//  Copyright © 2020 Strange. All rights reserved.
//

import Foundation

class DashboardVM: DashboardVMProtocol {

	var updateCallback: ResultCallback<Void>?
	var loadDataCallback: VoidCallback?
	var onPressed: ((_ general: Currency, _ secondary: Currency) -> Void)?

	private let apiService: RatesAPIServiceProtocol = APIService()
	private var displayModels: [CurrencyDMProtocol] = []
	private var currencies: [Currency] = []

	var countOfItems: Int {
		return displayModels.isEmpty ? 0 : displayModels.count + 1
	}

	var isEnabledFunnyMode: Bool = false

	func startFunnyMode() {
		isEnabledFunnyMode = true

		let selectionFeedback = HapticFeedback.notification(.success)
		let soundUrl = Bundle.main.url(forResource: "cat", withExtension: "m4a")
		FeedbackEffect.play(sound: soundUrl, feedback: selectionFeedback)
	}

	func stopFunnyMode() {
		isEnabledFunnyMode = false
		FeedbackEffect.stopSound()
		FeedbackEffect.play(sound: nil, feedback: HapticFeedback.notification(.success))
	}

	func itemType(atIndex index: Int) -> DashboardItemType {
		return index == (countOfItems - 1) ? .button : .currency
	}

	func displayModel(atIndex index: Int) -> CurrencyDMProtocol {
		return displayModels[index]
	}

	func selectItem(atIndex index: Int) {
		let dm = displayModels[index]
		onPressed?(Currency(rate: 1.0, type: .USD), Currency(rate: dm.price, type: dm.currency))
	}

	func fetchRates() {
		loadDataCallback?()
		apiService.rates { [weak self] result in
			switch result {
			case .failure(let error):
				self?.updateCallback?(Result.failure(error))

			case .success(let response):
				// Надо это будет сделать по другому, но пока мусор приходит в json
				var displayModels: [CurrencyDMProtocol] = []
				for dictionary in response.rates {
					guard let currency = CurrencyType(rawValue: dictionary.key) else { continue }
					displayModels.append(CurrencyDM(currency: currency, price: dictionary.value))
				}

				displayModels = displayModels.sorted(by: { $0.order < $1.order }).filter{ $0.order >= 0 }
				self?.displayModels = displayModels
				self?.updateCallback?(Result.success(Void()))
			}
		}
	}
}
