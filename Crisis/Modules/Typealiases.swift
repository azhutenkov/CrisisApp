//
//  Typealiases.swift
//  carsharing
//
//  Created by Alexey Zhutenkov on 24/11/2019.
//

import Foundation

typealias VoidCallback = () -> Void
typealias UpdateCallback<T> = (T) -> Void
typealias ResultCallback<T> = (Result<T, Error>) -> Void
