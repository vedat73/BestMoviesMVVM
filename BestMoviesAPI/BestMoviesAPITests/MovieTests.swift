//
//  MovieTests.swift
//  BestMoviesAPITests
//
//  Created by Vedat Ozlu on 19.08.2023.
//

import XCTest
@testable import BestMoviesAPI

final class MovieTests: XCTestCase {

    func testParsing() throws {
        let bundle = Bundle(for: MovieTests.self)
        let url = bundle.url(forResource: "movie", withExtension: "json")
        let data = try Data(contentsOf: url!)
        let decoder = Decoders.plainDateDecoder
        let movie = try decoder.decode(Movie.self, from: data)
        
        XCTAssertEqual(movie.name.value, "No Hard Feelings")
        XCTAssertEqual(movie.price?.value, "$19.99")
        XCTAssertEqual(movie.releaseDate?.attributes?.value, "June 16, 2023")
        XCTAssertEqual(movie.images.count, 3)
    }

}
