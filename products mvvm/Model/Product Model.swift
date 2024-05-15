//
//  Product Model.swift
//  products mvvm
//
//  Created by SUMSKAR PC on 11/05/24.
//

import Foundation
struct Product: Codable {
    let id: Int
    let title: String
    let price: Double
    let description, category: String
    let image: String
    let rating: Rating
}

// MARK: - Rating
struct Rating: Codable {
    let rate: Double
    let count: Int
}
