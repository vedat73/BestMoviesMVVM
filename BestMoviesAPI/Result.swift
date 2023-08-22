//
//  Result.swift
//  BestMoviesAPI
//
//  Created by Vedat Ozlu on 19.08.2023.
//

import Foundation

public enum Result<Value> {
    case success(Value)
    case failure(Error)
}
