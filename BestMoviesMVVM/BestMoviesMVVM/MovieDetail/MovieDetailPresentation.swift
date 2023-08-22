//
//  MovieDetailPresentation.swift
//  BestMoviesMVVM
//
//  Created by Vedat Ozlu on 19.08.2023.
//

import Foundation
import BestMoviesAPI

struct MovieDetailPresentation {
    let title: String
    let price: String
    let summary: String
    var imageUrl: String?
}

extension MovieDetailPresentation {
    init(movie: Movie) {
        self.init(title: movie.name.value, price: movie.price?.value ?? "", summary: movie.summary?.value ?? "",imageUrl: movie.imageURL?.first?.value)
    }
}
