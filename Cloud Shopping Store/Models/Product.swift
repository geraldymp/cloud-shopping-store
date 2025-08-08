//
//  Product.swift
//  Cloud Shopping Store
//
//  Created by Geraldy on 06/08/25.
//

import Foundation

struct Products: Codable {
    let products: [Product]
}

struct Product: Codable, Identifiable {
    let id: Int
    let title: String
    let thumbnail: String
    let price: Double
    let rating: Double
    let description: String
}
