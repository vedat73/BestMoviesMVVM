//
//  StatusCode+Helper.swift
//  BestMoviesAPI
//
//  Created by Vedat Ozlu on 8.09.2023.
//

import Foundation

extension Int {
    
    var isSuccess: Bool {
        return (200..<300).contains(self)
    }
}
