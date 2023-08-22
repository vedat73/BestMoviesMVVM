//
//  MovieDetailViewModel.swift
//  BestMoviesMVVM
//
//  Created by Vedat Ozlu on 20.08.2023.
//

import Foundation
import BestMoviesAPI

final class MovieDetailViewModel: MovieDetailViewModelProtocol {
    var delegate: MovieDetailViewModelDelegate?
    private let presentation: MovieDetailPresentation
    
    init(movie: Movie) {
        self.presentation = MovieDetailPresentation(movie: movie)
    }
    
    func load() {
        delegate?.showDetail(presentation)
    }
}
