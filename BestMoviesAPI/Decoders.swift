//
//  Decoders.swift
//  BestMoviesAPI
//
//  Created by Vedat Ozlu on 19.08.2023.
//

import Foundation

public enum Decoders {
    public static let plainDateDecoder: JSONDecoder = {
        // 2023-06-16T00:00:00-07:00
        let decoder = JSONDecoder()
        //        let dateFormatter = DateFormatter()
        //        dateFormatter.dateFormat = "yyyy-MM-dd"
        //        decoder.dateDecodingStrategy = .formatted(dateFormatter)
        return decoder
    }()
}
