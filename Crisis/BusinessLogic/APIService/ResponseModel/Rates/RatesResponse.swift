//
//  CurrencyResponseProtocol.swift
//  Crisis
//
//  Created by Alexey Zhutenkov on 09/03/2020.
//  Copyright © 2020 Strange. All rights reserved.
//

import Foundation

struct RatesResponse: RatesResponseProtocol {

	var rates: [String : Double]
}

extension RatesResponse: Decodable {

	// MARK - Decodable
	enum CodingKeys: String, CodingKey {
		case rates
	}

	public init(from decoder: Decoder) throws {
		let container = try decoder.container(keyedBy: CodingKeys.self)
		rates = try container.decode([String : Double].self, forKey: .rates)
	}
}
