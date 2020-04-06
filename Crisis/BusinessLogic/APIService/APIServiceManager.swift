//
//  APIManager.swift
//  Crisis
//
//  Created by Alexey Zhutenkov on 09/03/2020.
//  Copyright © 2020 Strange. All rights reserved.
//

import Alamofire

public class APIServiceManager {

	public init() {}

	private let session = Session()

	public func performRequest<T: Decodable>(
		route: URLRequestConvertible,
		parameters customParameters: Parameters? = nil,
		validator customValidator: DataRequest.Validation? = nil,
		decoder: JSONDecoder = JSONDecoder(),
		completion: @escaping (Result<T, Error>) -> Void
	) {

		URLCache.shared.removeAllCachedResponses()
		let request = session.request(route)
		request.responseDecodable(of: T.self, queue: DispatchQueue.main, decoder: decoder) { response in

			#if DEBUG
			print("\n")
			print("Request:")
			print(response.request ?? "")
			if let responseData = response.data,
				let requestData = response.request?.httpBody,
				let dataString = String(data: responseData, encoding: .utf8) {
				print(String(data: requestData, encoding: .utf8) ?? "")
				print("\n")
				print("Response:")
				print(dataString)
			}
			print("\n")
			#endif

			switch response.result {
			case .failure(let error):
				completion(Result.failure(error))
			case .success(let object):
				completion(Result.success(object))
			}
		}
	}
}
