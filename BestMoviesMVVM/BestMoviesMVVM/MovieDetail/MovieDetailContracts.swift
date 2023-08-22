//
//  MovieDetailContracts.swift
//  BestMoviesMVVM
//
//  Created by Vedat Ozlu on 20.08.2023.
//

import Foundation

protocol MovieDetailViewModelProtocol {
    var delegate: MovieDetailViewModelDelegate? { get set }
    func load()
}
protocol MovieDetailViewModelDelegate {
    func showDetail(_ presentation: MovieDetailPresentation)
}
