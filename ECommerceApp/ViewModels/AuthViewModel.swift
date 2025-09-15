//
//  AuthViewModel.swift
//  ECommerceApp
//
//  Created by saurabh chaudhari on 21/08/25.
//

import Foundation
import SwiftUI

@MainActor
final class AuthViewModel: ObservableObject {
    @Published var email: String = "eve.holt@reqres.in"
    @Published var password: String = "cityslicka"
    @Published var isLoading: Bool = false
    @Published var errorMessage: String?
    @AppStorage("isLoggedIn") var isLoggedIn: Bool = false
    @Published var currentUser: UserM?

    func login() {
        Task {
            await loginAsync()
        }
    }

    func loginAsync() async {
        errorMessage = nil
        isLoading = true
//        do {
//            let user = try await APIService.shared.login(email: email, password: password)
//            currentUser = user
//            isLoggedIn = true
//        } catch {
//            errorMessage = (error as? LocalizedError)?.errorDescription ?? "Login failed"
//        }
        // Fake user until API is ready
        currentUser = UserM(token: "1234", email: "saurabh@abc.com")
        isLoggedIn = true
        isLoading = false
    }

    func logout() {
        isLoggedIn = false
        currentUser = nil
        email = ""
        password = ""
    }
}

