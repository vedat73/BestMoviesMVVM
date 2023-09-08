//
//  Environment.swift
//  BestMoviesAPI
//
//  Created by Vedat Ozlu on 8.09.2023.
//

import Foundation

enum Environment {
    
    // MARK: - Best Movies Base URL
    
    static let apiBaseURLString = "http://ax.itunes.apple.com/WebObjects/MZStoreServices.woa/ws/RSS/topMovies/json"
    
    static var apiBaseURL: URL {
        URL(string: apiBaseURLString)!
    }
}
