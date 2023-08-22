//
//  BestMoviesService.swift
//  BestMoviesAPI
//
//  Created by Vedat Ozlu on 19.08.2023.
//

import Foundation
import Alamofire

public protocol BestMoviesServiceProtocol {
    func fetchBestMovies(completion: @escaping (Result<BestMoviesResponse>) -> Void)
}

public final class BestMoviesService: BestMoviesServiceProtocol {
    
    public enum Error: Swift.Error {
        case serializationError(internal: Swift.Error)
        case networkError(internal: Swift.Error)
    }
    
    public init() { }
    
    public func fetchBestMovies(completion: @escaping (Result<BestMoviesResponse>) -> Void) {
        //http://ax.itunes.apple.com/WebObjects/MZStoreServices.woa/ws/RSS/topMovies/json
        let urlString = "http://ax.itunes.apple.com/WebObjects/MZStoreServices.woa/ws/RSS/topMovies/json"
        AF.request(urlString).responseData { response in
            switch response.result {
                case .success(let data):
                    let decoder = Decoders.plainDateDecoder
                    do {
                        let response = try decoder.decode(BestMoviesResponse.self, from: data)
                        completion(.success(response))
                    } catch {
                        completion(.failure(Error.serializationError(internal: error)))
                    }
                case .failure(let error):
                    completion(.failure(Error.networkError(internal: error)))
            }
        }
    }
}
