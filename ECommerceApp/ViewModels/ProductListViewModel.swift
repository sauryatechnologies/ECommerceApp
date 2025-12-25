//
//  ProductListViewModel.swift
//  ECommerceApp
//
//  Created by saurabh chaudhari on 21/08/25.
//

import Foundation

@MainActor
final class ProductListViewModel: ObservableObject {
    @Published private(set) var products: [ProductM] = []
    @Published var isLoading = false
    @Published var errorMessage: String?
    private(set) var loadedOnce = false
    
    private let apiService: ProductAPIServiceProtocol
    
    init(apiService: ProductAPIServiceProtocol = APIService.shared) {
            self.apiService = apiService
        }

    /// Fetch only on first appearance of Products tab.
    func fetchIfNeeded() {
        guard loadedOnce == false else { return }
        Task { await fetch() }
    }

    func fetch(force: Bool = false) async {
        if loadedOnce && !force { return }
        print("fetch product +++++++++")
        isLoading = true
        errorMessage = nil
        do {
            let list = try await apiService.fetchProducts()
            products = list
            loadedOnce = true
        } catch {
            errorMessage = (error as? LocalizedError)?.errorDescription ?? "Failed to load products"
        }
        isLoading = false
    }
}

