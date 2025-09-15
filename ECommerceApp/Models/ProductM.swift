//
//  ProductM.swift
//  ECommerceApp
//
//  Created by saurabh chaudhari on 21/08/25.
//

import Foundation

struct ProductM: Identifiable, Codable, Equatable, Hashable {
    let id: Int
    let title: String
    let price: Double
    let description: String
    let category: String
    let image: String
    let rating: Rating?

    struct Rating: Codable, Equatable, Hashable {
        let rate: Double
        let count: Int
    }
}
