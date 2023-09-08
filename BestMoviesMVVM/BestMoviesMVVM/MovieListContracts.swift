//
//  MovieListContracts.swift
//  BestMoviesMVVM
//
//  Created by Vedat Ozlu on 20.08.2023.
//

import Combine
import Foundation

protocol MovieListViewModelProtocol {
    // MARK: - Properties
    
    var loadingPublisher: AnyPublisher<Bool, Never> { get }
    var hasBestMoviesDataPublisher: AnyPublisher<Bool, Never> { get }
    var hasErrorPublisher: AnyPublisher<Bool, Never> { get }
    var bestMoviesStatePublisher : AnyPublisher<BestMoviesAPIState, Never> { get }
    
    // MARK: - Functions
    
    func load()
    func selectMovie(at index: Int) -> MovieDetailViewModel
}
