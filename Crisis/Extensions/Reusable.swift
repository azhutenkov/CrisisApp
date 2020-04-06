//
//  Reusable.swift
//  carsharing
//
//  Created by Alexey Zhutenkov on 06/10/2019.
//

import Foundation

protocol Reusable: class {
	static var reuseIdentifier: String { get }
}

extension Reusable {
	static var reuseIdentifier: String {
		return "\(self)"
	}
}
