//
//  MovieListViewModel.swift
//  BestMoviesMVVM
//
//  Created by Vedat Ozlu on 20.08.2023.
//

import Foundation
import BestMoviesAPI

final class MovieListViewModel: MovieListViewModelProtocol {
    var delegate: MovieListViewModelDelegate?
    private let service: BestMoviesServiceProtocol
    private var movies: [Movie] = []
    init(service: BestMoviesServiceProtocol) {
        self.service = service
    }
    
    func load() {
        notify(.updateTitle("Movies"))
        notify(.setLoading(true))
        
        service.fetchBestMovies {[weak self] result in
            guard let self = self else { return }
            self.notify(.setLoading(false))
            
            switch result {
                case .success(let response):
                    self.movies = response.entry
                    let presentations = response.entry.map { MoviePresentation(movie: $0) }
                    self.notify(.showMovieList(presentations))
                case .failure(let error):
                    print(error.localizedDescription)
            }
        }
    }
      
    func selectMovie(at index: Int) {
        let movie = movies[index]
        let detailViewModel = MovieDetailViewModel(movie: movie)
        delegate?.navigate(to: .detail(detailViewModel))
    }
    
    private func notify(_ output: MovieListViewModelOutput) {
        delegate?.handleViewModelOutput(output)
    }
    
}
