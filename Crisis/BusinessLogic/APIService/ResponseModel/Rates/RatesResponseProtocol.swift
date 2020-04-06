//
//  RatesResponseProtocol.swift
//  Crisis
//
//  Created by Alexey Zhutenkov on 09/03/2020.
//  Copyright © 2020 Strange. All rights reserved.
//

import Foundation

protocol RatesResponseProtocol {
	var rates: [String : Double] { get }
}
