//
//  ProductListViewModelTests.swift
//  ECommerceAppTests
//
//  Created by Saurabh Chaudhari on 24/12/25.
//

import XCTest
@testable import ECommerceApp

@MainActor
final class ProductListViewModelTests: XCTestCase {

    // MARK: - Helpers

    private func makeProduct(
        id: Int,
        title: String = "iPhone",
        price: Double = 999,
        description: String = "Apple smartphone",
        category: String = "electronics",
        image: String = "https://example.com/image.png",
        rating: ProductM.Rating? = ProductM.Rating(rate: 4.5, count: 100)
    ) -> ProductM {
        ProductM(
            id: id,
            title: title,
            price: price,
            description: description,
            category: category,
            image: image,
            rating: rating
        )
    }

    // MARK: - Success Case

    func testFetchProductsSuccess() async {
        // GIVEN
        let products = [
            makeProduct(id: 1, title: "iPhone"),
            makeProduct(id: 2, title: "MacBook")
        ]

        let mockService = MockProductAPIService(
            result: .success(products)
        )

        let vm = ProductListViewModel(apiService: mockService)

        // WHEN
        await vm.fetch()

        // THEN
        XCTAssertEqual(vm.products.count, 2)
        XCTAssertEqual(vm.products.first?.title, "iPhone")
        XCTAssertTrue(vm.loadedOnce)
        XCTAssertFalse(vm.isLoading)
        XCTAssertNil(vm.errorMessage)
    }

    // MARK: - Failure Case

    func testFetchProductsFailure() async {
        // GIVEN
        let mockService = MockProductAPIService(
            result: .failure(URLError(.badServerResponse))
        )

        let vm = ProductListViewModel(apiService: mockService)

        // WHEN
        await vm.fetch()

        // THEN
        XCTAssertTrue(vm.products.isEmpty)
        XCTAssertNotNil(vm.errorMessage)
        XCTAssertFalse(vm.isLoading)
        XCTAssertFalse(vm.loadedOnce)
    }

    // MARK: - Fetch Only Once Logic

    func testFetchIfNeededCalledOnlyOnce() async {
        // GIVEN
        let products = [
            makeProduct(id: 1)
        ]

        let mockService = MockProductAPIService(
            result: .success(products)
        )

        let vm = ProductListViewModel(apiService: mockService)

        // WHEN
        vm.fetchIfNeeded()

        // Allow async task to finish
        try? await Task.sleep(nanoseconds: 300_000_000)

        XCTAssertEqual(vm.products.count, 1)
        XCTAssertTrue(vm.loadedOnce)

        // Second call should not refetch
        vm.fetchIfNeeded()
        XCTAssertEqual(vm.products.count, 1)
    }

    // MARK: - Force Fetch Overrides loadedOnce

    func testFetchWithForceIgnoresLoadedOnce() async {
        // GIVEN
        let initialProducts = [
            makeProduct(id: 1, title: "Old Product")
        ]

        let updatedProducts = [
            makeProduct(id: 2, title: "New Product")
        ]

        let mockService = MockProductAPIService(
            result: .success(initialProducts)
        )

        let vm = ProductListViewModel(apiService: mockService)

        // Initial fetch
        await vm.fetch()
        XCTAssertEqual(vm.products.first?.title, "Old Product")

        // Update mock response
        mockService.result = .success(updatedProducts)

        // WHEN (force fetch)
        await vm.fetch(force: true)

        // THEN
        XCTAssertEqual(vm.products.count, 1)
        XCTAssertEqual(vm.products.first?.title, "New Product")
    }

    // MARK: - Loading State

    func testLoadingStateDuringFetch() async {
        // GIVEN
        let mockService = DelayedMockProductAPIService(
            delay: 0.2,
            result: .success([makeProduct(id: 1)])
        )

        let vm = ProductListViewModel(apiService: mockService)

        // WHEN
        let task = Task {
            await vm.fetch()
        }

        // Small delay to catch loading state
        try? await Task.sleep(nanoseconds: 50_000_000)

        // THEN
        XCTAssertTrue(vm.isLoading)

        await task.value
        XCTAssertFalse(vm.isLoading)
    }
}

