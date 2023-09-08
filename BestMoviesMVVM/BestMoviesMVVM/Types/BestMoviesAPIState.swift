//
//  BestMoviesAPIState.swift
//  BestMoviesMVVM
//
//  Created by Vedat Ozlu on 8.09.2023.
//

import Foundation
import BestMoviesAPI

enum BestMoviesAPIState {
    
    // MARK: - Cases
    
    case loading
    case data([MoviePresentation])
    case error(BestMoviesAPIError)

    var isLoading: Bool {
        switch self {
            case .loading:
                return true
            case .data, .error:
                return false
        }
    }
    
    var bestMoviesResponseData: [MoviePresentation]? {
        switch self {
            case .data(let moviesResponse):
                return moviesResponse
            case .error, .loading:
                return nil
        }
    }
    
    var bestMoviesAPIError: BestMoviesAPIError? {
        switch self {
            case .error(let moviesAPIError):
                return moviesAPIError
            case .data, .loading:
                return nil
        }
    }
   
}
