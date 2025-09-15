//
//  ProductDetailViewModel.swift
//  ECommerceApp
//
//  Created by saurabh chaudhari on 21/08/25.
//

import Foundation

@MainActor
final class ProductDetailViewModel: ObservableObject {
    @Published private(set) var product: ProductM
    @Published var isLoading = false
    @Published var errorMessage: String?

    init(product: ProductM) {
        self.product = product
    }

    /// Optionally refresh detail from API (e.g., for latest rating/count)
    func refresh() async {
        isLoading = true
        errorMessage = nil
        do {
            let fresh = try await APIService.shared.fetchProductDetail(id: product.id)
            product = fresh
        } catch {
            errorMessage = (error as? LocalizedError)?.errorDescription ?? "Failed to load product detail"
        }
        isLoading = false
    }
}

