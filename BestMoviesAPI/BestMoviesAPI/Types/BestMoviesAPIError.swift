//
//  BestMoviesAPIError.swift
//  BestMoviesAPI
//
//  Created by Vedat Ozlu on 8.09.2023.
//

import Foundation

public enum BestMoviesAPIError: Error {
    
    // MARK: - Cases
    
    case failedRequest
    case invalidResponse
    case noInternetConnection
}
