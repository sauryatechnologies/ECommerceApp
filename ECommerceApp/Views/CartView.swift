//
//  CartView.swift
//  ECommerceApp
//
//  Created by saurabh chaudhari on 21/08/25.
//

import SwiftUI

struct CartView: View {
    @EnvironmentObject var cartVM: CartViewModel

    var body: some View {
            Group {
                if cartVM.items.isEmpty {
//                    ContentUnavailableView("Your cart is empty", systemImage: "cart", description: Text("Add some products from the Products tab."))
                    Text("Add some products from the Products tab.")
                } else {
                    List {
                        ForEach(cartVM.items) { item in
                            HStack {
                                VStack(alignment: .leading) {
                                    Text(item.product.title).font(.subheadline).lineLimit(2)
                                    Text("$\(item.product.price, specifier: "%.2f") each")
                                        .font(.caption).foregroundColor(.secondary)
                                }
                                Spacer()
                                Stepper(value: Binding(
                                    get: { item.quantity },
                                    set: { newValue in
                                        if newValue > item.quantity {
                                            Task { await cartVM.addViaAPI(product: item.product) }
                                        } else if newValue < item.quantity {
                                            Task { await cartVM.removeViaAPI(item: item) }
                                        }
                                    }
                                ), in: 1...20) {
                                    Text("Qty: \(item.quantity)")
                                }
                                .frame(width: 140)
                            }
                            .swipeActions {
                                Button(role: .destructive) {
                                    cartVM.delete(item: item)
                                } label: {
                                    Label("Delete", systemImage: "trash")
                                }
                            }
                        }

                        HStack {
                            Text("Total")
                                .font(.headline)
                            Spacer()
                            Text("$\(cartVM.totalAmount, specifier: "%.2f")")
                                .font(.headline)
                        }
                    }
                    .listStyle(.insetGrouped)
                }
            }
            .navigationTitle("Cart")
        
    }
}

struct CartView_Previews: PreviewProvider {
    static var previews: some View {
        CartView()
    }
}

