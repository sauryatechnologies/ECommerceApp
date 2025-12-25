//
//  DelayedMockProductAPIService.swift
//  ECommerceAppTests
//
//  Created by saurabh chaudhari on 24/12/25.
//

import Foundation
@testable import ECommerceApp

final class DelayedMockProductAPIService: ProductAPIServiceProtocol {

    let delay: TimeInterval
    let result: Result<[ProductM], Error>

    init(delay: TimeInterval, result: Result<[ProductM], Error>) {
        self.delay = delay
        self.result = result
    }

    func fetchProducts() async throws -> [ProductM] {
        try await Task.sleep(nanoseconds: UInt64(delay * 1_000_000_000))
        return try result.get()
    }
}
