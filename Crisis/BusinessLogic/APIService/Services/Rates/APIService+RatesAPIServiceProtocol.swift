//
//  APIService+RatesAPIServiceProtocol.swift
//  Crisis
//
//  Created by Alexey Zhutenkov on 09/03/2020.
//  Copyright © 2020 Strange. All rights reserved.
//

import Foundation
import Alamofire

private enum RatesRoutes: URLRequestConvertible {

	case fetch

	var path: String {
		return APIConstants.ratesURL
	}

	func asURLRequest() throws -> URLRequest {
		let dataRequest = AF.request(path, method: .get)
		return try dataRequest.convertible.asURLRequest()
	}
}

extension APIService: RatesAPIServiceProtocol {

	func rates(completion: @escaping (Result<RatesResponse, Error>) -> Void) {
		apiServiceManager.performRequest(route: RatesRoutes.fetch, completion: completion)
	}
}
