//
//  AppContainer.swift
//  BestMoviesMVVM
//
//  Created by Vedat Ozlu on 19.08.2023.
//

import Foundation
import BestMoviesAPI
import MediaAPI

let app = AppContainer()

final class AppContainer {
    let router = AppRouter()
    let service = BestMoviesReactiveService()
    let mediaService = MediaService()
}
