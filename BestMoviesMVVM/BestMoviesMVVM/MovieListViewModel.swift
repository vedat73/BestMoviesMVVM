//
//  MovieListViewModel.swift
//  BestMoviesMVVM
//
//  Created by Vedat Ozlu on 20.08.2023.
//

import BestMoviesAPI
import Combine
import Foundation


final class MovieListViewModel: MovieListViewModelProtocol {
    
    // MARK: - Properties
    
    var loadingPublisher: AnyPublisher<Bool, Never> {
        bestMoviesStatePublisher
            .compactMap { $0.isLoading }
            .eraseToAnyPublisher()
    }
    
    var hasBestMoviesDataPublisher: AnyPublisher<Bool, Never> {
        bestMoviesStatePublisher
            .compactMap { $0.bestMoviesResponseData != nil }
            .eraseToAnyPublisher()
    }
    
    var hasErrorPublisher: AnyPublisher<Bool, Never> {
        bestMoviesStatePublisher
            .compactMap { $0.bestMoviesAPIError != nil }
            .eraseToAnyPublisher()
    }
    
    private let service: BestMoviesReactiveServiceProtocol
    
    private var movies: [Movie] = []
    
    private let bestMoviesStateSubject = PassthroughSubject<BestMoviesAPIState, Never>()
    
    var bestMoviesStatePublisher : AnyPublisher<BestMoviesAPIState, Never> {
        bestMoviesStateSubject
            .eraseToAnyPublisher()
    }
    
    private var subscriptions: Set<AnyCancellable> = []
    
    // MARK: - Initialization
    
    init(service: BestMoviesReactiveServiceProtocol) {
        self.service = service
    }
    
    
    func load() {
        
        bestMoviesStateSubject.send(.loading)
        
        service.fetchBestMovies()
            .sink { [weak self] completion in
                switch completion {
                    case .finished:
                        break
                    case .failure(let error):
                        self?.bestMoviesStateSubject.send(.error(error))
                }
            } receiveValue: { [weak self] data in
                
                guard let self = self else { return }
               
                self.movies = data.entry
                let presentations = data.entry.map { MoviePresentation(movie: $0) }
                
                self.bestMoviesStateSubject.send(.data(presentations))
            }
            .store(in: &subscriptions)
    }
      
    func selectMovie(at index: Int) -> MovieDetailViewModel {
        let movie = movies[index]
        return MovieDetailViewModel(movie: movie)
        /*let detailViewModel = MovieDetailViewModel(movie: movie)
        bestMoviesStateSubject.send(.navigate(.detail(detailViewModel)))*/
    }
    
}
