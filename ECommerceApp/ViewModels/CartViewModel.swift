//
//  CartViewModel.swift
//  ECommerceApp
//
//  Created by saurabh chaudhari on 21/08/25.
//

import Foundation

@MainActor
final class CartViewModel: ObservableObject {
    @Published private(set) var items: [CartItemM] = []

    var totalQuantity: Int {
        items.reduce(0) { $0 + $1.quantity }
    }

    var totalAmount: Double {
        items.reduce(0) { $0 + (Double($1.quantity) * $1.product.price) }
    }

    func add(product: ProductM) {
        if let idx = items.firstIndex(where: { $0.product.id == product.id }) {
            items[idx].quantity += 1
        } else {
            items.append(CartItemM(id: product.id, product: product, quantity: 1))
        }
    }

    func remove(item: CartItemM) {
        guard let idx = items.firstIndex(of: item) else { return }
        if items[idx].quantity > 1 {
            items[idx].quantity -= 1
        } else {
            items.remove(at: idx)
        }
    }

    func delete(item: CartItemM) {
        items.removeAll { $0.id == item.id }
    }

    // With simulated API
    func addViaAPI(product: ProductM) async {
        do {
            try await APIService.shared.addToCart(product: product)
            add(product: product)
        } catch { /* handle if needed */ }
    }

    func removeViaAPI(item: CartItemM) async {
        do {
            try await APIService.shared.removeFromCart(item: item)
            remove(item: item)
        } catch { /* handle if needed */ }
    }
}

