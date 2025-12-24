//
//  ProductListView.swift
//  ECommerceApp
//
//  Created by saurabh chaudhari on 21/08/25.
//

import SwiftUI

// MARK: - Main View
struct ProductListView: View {
    @StateObject private var vm = ProductListViewModel()
    @EnvironmentObject var cartVM: CartViewModel
    @State private var searchText = ""
    @State private var showCart = false   // <--- for navigation
    @Binding var selectedTab: Tab   // 👈 comes from MainTabView
    
    // Computed filtered list
    private var filteredProducts: [ProductM] {
        if searchText.isEmpty {
            return vm.products
        } else {
            return vm.products.filter {
                $0.title.localizedCaseInsensitiveContains(searchText)
            }
        }
    }
    
    var body: some View {
        contentView
            .navigationTitle("Products")
            .searchable(text: $searchText,
                        placement: .navigationBarDrawer(displayMode: .automatic),
                        prompt: "Search products")
        // 🔹 Cart button in Navigation Bar
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    CartButton {
                        selectedTab = .cart
                    }
                }
            }
            .task { vm.fetchIfNeeded() }
        
    }
}

// MARK: - Content Builder
private extension ProductListView {
    @ViewBuilder
    var contentView: some View {
        if vm.isLoading && vm.products.isEmpty {
            ProgressView("Loading products…")
        } else if let err = vm.errorMessage {
            ErrorView(message: err) {
                Task { await vm.fetch(force: true) }
            }
        } else {
            ProductList(products: filteredProducts) { product in
                Task { await cartVM.addViaAPI(product: product) }
            } onRefresh: {
                await vm.fetch(force: true)
            }
            
        }
    }
}

// MARK: - Subviews
struct ErrorView: View {
    let message: String
    let retry: () -> Void
    
    var body: some View {
        VStack(spacing: 8) {
            Text(message)
                .foregroundColor(.red)
            Button("Retry", action: retry)
        }
        .padding()
    }
}

struct ProductList: View {
    let products: [ProductM]
    let addToCart: (ProductM) -> Void
    let onRefresh: () async -> Void
    
    var body: some View {
        List(products) { product in
            NavigationLink(value: product) {
                ProductRow(product: product, addToCart: addToCart)
            }
        }
        .listStyle(.plain)
        // 🔹 Pull-to-refresh
        .refreshable {
            await onRefresh()
        }
        .navigationDestination(for: ProductM.self) { product in
            ProductDetailView(product: product)
        }
    }
}

struct ProductRow: View {
    let product: ProductM
    let addToCart: (ProductM) -> Void
    
    @State private var showAlert = false
    
    var body: some View {
        HStack(spacing: 12) {
            AsyncImage(url: URL(string: product.image)) { phase in
                switch phase {
                case .empty: ProgressView()
                case .success(let img): img.resizable().scaledToFit()
                case .failure: Image(systemName: "photo")
                        .resizable().scaledToFit()
                @unknown default: EmptyView()
                }
            }
            .frame(width: 64, height: 64)
            .cornerRadius(8)
            
            VStack(alignment: .leading, spacing: 6) {
                Text(product.title)
                    .font(.subheadline)
                    .lineLimit(2)
                Text("$\(product.price, specifier: "%.2f")")
                    .font(.callout)
                    .foregroundColor(.secondary)
            }
            Spacer()
            
            Button {
                addToCart(product)
                showAlert = true
            } label: {
                Image(systemName: "cart.badge.plus")
            }
            .buttonStyle(.bordered)
            .alert("Added to Cart", isPresented: $showAlert) {
                Button("OK", role: .cancel) { }
            } message: {
                Text("\(product.title) has been added to your cart.")
            }
        }
        .padding(.vertical, 4)
        .accessibilityElement(children: .combine)
        .accessibilityIdentifier("testProduct.\(product.id)")
    }
}

struct ProductListView_Previews: PreviewProvider {
    static var previews: some View {
        ProductListView(selectedTab: .constant(.products))
            .environmentObject(CartViewModel())   // 👈 if your view needs it
    }
}
