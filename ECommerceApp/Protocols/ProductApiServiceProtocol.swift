//
//  ProductApiServiceProtocol.swift
//  ECommerceApp
//
//  Created by saurabh chaudhari on 24/12/25.
//

import Foundation

protocol ProductAPIServiceProtocol {
    func fetchProducts() async throws -> [ProductM]
}
