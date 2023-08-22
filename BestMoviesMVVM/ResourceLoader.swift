//
//  ResourceLoader.swift
//  BestMoviesMVVM
//
//  Created by Vedat Ozlu on 19.08.2023.
//

import Foundation
import BestMoviesAPI

class ResourceLoader {
    enum MovieResuorce: String {
        case movie1
        case movie2
        case movie3
    }
    
    static func loadMovie(resource: MovieResuorce) throws -> Movie {
        let bundle = Bundle.test
        let url =  bundle.url(forResource: resource.rawValue, withExtension: "json").unsafelyUnwrapped
        let data = try Data(contentsOf: url)
        let decoder = Decoders.plainDateDecoder
        let movie = try decoder.decode(Movie.self, from: data)
        return movie
    }
}
private extension Bundle {
    class Dummy { }
    static let test = Bundle(for: Dummy.self)
}
