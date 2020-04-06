//
//  RatesAPIServiceProtocol.swift
//  Crisis
//
//  Created by Alexey Zhutenkov on 09/03/2020.
//  Copyright © 2020 Strange. All rights reserved.
//

protocol RatesAPIServiceProtocol {
	func rates(completion: @escaping(Result<RatesResponse, Error>) -> Void)
}
