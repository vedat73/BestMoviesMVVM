//
//  MoviePresentation.swift
//  BestMoviesMVVM
//
//  Created by Vedat Ozlu on 20.08.2023.
//

import Foundation
import BestMoviesAPI

final class MoviePresentation: NSObject {
    let title: String
    let detail: String
    
    init(title: String, detail: String) {
        self.title = title
        self.detail = detail
        super.init()
    }
}

extension MoviePresentation {
    convenience init(movie: Movie) {
        self.init(title: movie.name.value, detail: movie.price?.value ?? "")
    }
}
