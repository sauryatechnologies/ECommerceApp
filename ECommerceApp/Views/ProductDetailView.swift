//
//  ProductDetailView.swift
//  ECommerceApp
//
//  Created by saurabh chaudhari on 21/08/25.
//

import SwiftUI

struct ProductDetailView: View {
    @EnvironmentObject var cartVM: CartViewModel
    @StateObject private var vm: ProductDetailViewModel

    init(product: ProductM) {
        _vm = StateObject(wrappedValue: ProductDetailViewModel(product: product))
    }

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                AsyncImage(url: URL(string: vm.product.image)) { phase in
                    switch phase {
                    case .empty: ProgressView()
                    case .success(let img): img.resizable().scaledToFit()
                    case .failure: Image(systemName: "photo").resizable().scaledToFit()
                    @unknown default: EmptyView()
                    }
                }
                .frame(maxWidth: .infinity)
                .frame(height: 260)
                .background(Color(.secondarySystemBackground))
                .cornerRadius(12)

                Text(vm.product.title).font(.title3).bold()
                Text(vm.product.description).font(.body)
                HStack {
                    Text("Category: \(vm.product.category)").font(.subheadline).foregroundColor(.secondary)
                    Spacer()
                    Text("$\(vm.product.price, specifier: "%.2f")").bold()
                }

                if let r = vm.product.rating {
                    HStack(spacing: 12) {
                        Label("\(String(format: "%.1f", r.rate))", systemImage: "star.fill")
                        Text("(\(r.count)) reviews")
                    }
                    .font(.footnote)
                    .foregroundColor(.secondary)
                }

                Button {
                    Task { await cartVM.addViaAPI(product: vm.product) }
                } label: {
                    HStack {
                        Image(systemName: "cart.badge.plus")
                        Text("Add to Cart").bold()
                    }
                    .frame(maxWidth: .infinity)
                }
                .buttonStyle(.borderedProminent)
            }
            .padding()
        }
        .navigationTitle("Details")
        .navigationBarTitleDisplayMode(.inline)
        .task {
            // optional: refresh detail from API
            await vm.refresh()
        }
    }
}

struct ProductDetailView_Previews: PreviewProvider {
    static var previews: some View {
            let mockProduct = ProductM(
                id: 1,
                title: "Sample Product",
                price: 99.99,
                description: "This is a sample product used for preview purposes.",
                category: "Electronics",
                image: "https://via.placeholder.com/300",
                rating: ProductM.Rating(rate: 4.5, count: 120)
            )

            ProductDetailView(product: mockProduct)
                .environmentObject(CartViewModel())
        }
}
