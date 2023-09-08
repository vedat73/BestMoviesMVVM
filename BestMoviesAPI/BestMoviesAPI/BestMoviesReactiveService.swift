//
//  BestMoviesReactiveService.swift
//  BestMoviesAPI
//
//  Created by Vedat Ozlu on 8.09.2023.
//

import Combine
import Foundation

public protocol BestMoviesReactiveServiceProtocol {
    func fetchBestMovies() -> AnyPublisher<BestMoviesResponse, BestMoviesAPIError>
}

public final class BestMoviesReactiveService: BestMoviesReactiveServiceProtocol {
    
    // MARK: - Initialization
    
    public init() { }
    
    // MARK: - Service functions

    public func fetchBestMovies() -> AnyPublisher<BestMoviesResponse, BestMoviesAPIError> {
        let request = URLRequest(url: Environment.apiBaseURL)
        
        return URLSession.shared.dataTaskPublisher(for: request)
            .delay(for: 1 , scheduler: RunLoop.main)
            .retry(1)
            .tryMap { data, response in
                guard let statusCode = (response as? HTTPURLResponse)?.statusCode else {
                    throw BestMoviesAPIError.failedRequest
                }
                
                guard statusCode.isSuccess else {
                    throw BestMoviesAPIError.failedRequest
                }
                
                do {
                    return try Decoders.plainDateDecoder.decode(BestMoviesResponse.self, from: data)
                } catch {
                    throw BestMoviesAPIError.invalidResponse
                }
            }
            .mapError { error -> BestMoviesAPIError in
                switch error {
                    case let apiError as BestMoviesAPIError:
                        return apiError
                    case URLError.notConnectedToInternet:
                        return BestMoviesAPIError.noInternetConnection
                    default:
                        return BestMoviesAPIError.failedRequest
                }
            }
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
}
