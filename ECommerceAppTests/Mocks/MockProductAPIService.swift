//
//  MockProductAPIService.swift
//  ECommerceAppTests
//
//  Created by saurabh chaudhari on 24/12/25.
//

import Foundation
@testable import ECommerceApp

final class MockProductAPIService: ProductAPIServiceProtocol {

    var result: Result<[ProductM], Error>

    init(result: Result<[ProductM], Error>) {
        self.result = result
    }

    func fetchProducts() async throws -> [ProductM] {
        return try result.get()
    }
}
