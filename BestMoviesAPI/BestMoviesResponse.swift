//
//  BestMoviesResponse.swift
//  BestMoviesAPI
//
//  Created by Vedat Ozlu on 19.08.2023.
//

import Foundation

public struct BestMoviesResponse: Decodable {
    
    private enum RootCodingKeys: String, CodingKey {
        case feed
    }
    private enum FeedCodingKeys: String, CodingKey {
        case entry
    }
    
    public let entry: [Movie]
    
    public init(entry: [Movie]) {
        self.entry = entry
    }
    
    public init(from decoder: Decoder) throws {
        let rootContainer = try decoder.container(keyedBy: RootCodingKeys.self)
        let feedContainer = try rootContainer.nestedContainer(keyedBy: FeedCodingKeys.self, forKey: .feed)
        self.entry = try feedContainer.decode([Movie].self, forKey: .entry)
    }
}
