//
//  CartItemM.swift
//  ECommerceApp
//
//  Created by saurabh chaudhari on 21/08/25.
//

import Foundation

struct CartItemM: Identifiable, Equatable, Hashable {
    let id: Int
    let product: ProductM
    var quantity: Int
}

