//
//  movie.swift
//  BestMoviesAPI
//
//  Created by Vedat Ozlu on 19.08.2023.
//

import Foundation

public struct Movie: Decodable {
    public enum CodingKeys: String, CodingKey {
        case name = "im:name"
        case imageURL = "im:image"
        case summary
        case price = "im:price"
        case releaseDate = "im:releaseDate"
    }
    public let name: Label
    public let imageURL: [Label]?
    public let summary: Label?
    public let price: Label?
    public let releaseDate: DateLabel?
}

public struct DateLabel: Decodable {
    public let attributes: Label?
}

public struct Label: Decodable {
    enum CodingKeys: String, CodingKey {
        case value = "label"
    }
    public let value: String
}
