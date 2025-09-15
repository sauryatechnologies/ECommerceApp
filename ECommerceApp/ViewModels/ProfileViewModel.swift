//
//  ProfileViewModel.swift
//  ECommerceApp
//
//  Created by saurabh chaudhari on 21/08/25.
//

import Foundation

@MainActor
final class ProfileViewModel: ObservableObject {
    @Published var fullName: String = "John Appleseed"
    @Published var email: String = "john@example.com"
    @Published var memberSince: String = "2021"

    // You can add fetch from your real user endpoint here
}

