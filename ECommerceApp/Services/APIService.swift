//
//  APIService.swift
//  ECommerceApp
//
//  Created by saurabh chaudhari on 21/08/25.
//

import Foundation

enum APIError: Error, LocalizedError {
    case invalidURL
    case invalidResponse
    case server(Int)
    case decoding
    case unknown

    var errorDescription: String? {
        switch self {
        case .invalidURL: return "Invalid URL"
        case .invalidResponse: return "Invalid response"
        case .server(let code): return "Server error: \(code)"
        case .decoding: return "Failed to decode response"
        case .unknown: return "Unknown error"
        }
    }
}

final class APIService {
    static let shared = APIService()
    private init() {}

    // MARK: - Login (ReqRes)
    struct LoginResponse: Codable { let token: String }

    func login(email: String, password: String) async throws -> UserM {
        guard let url = URL(string: "https://reqres.in/api/login") else { throw APIError.invalidURL }
        var req = URLRequest(url: url)
        req.httpMethod = "POST"
        req.addValue("application/json", forHTTPHeaderField: "Content-Type")
        let body: [String: String] = ["email": email, "password": password]
        req.httpBody = try JSONEncoder().encode(body)

        let (data, resp) = try await URLSession.shared.data(for: req)
        guard let http = resp as? HTTPURLResponse else { throw APIError.invalidResponse }
        guard 200..<300 ~= http.statusCode else { throw APIError.server(http.statusCode) }

        do {
            let decoded = try JSONDecoder().decode(LoginResponse.self, from: data)
            return UserM(token: decoded.token, email: email)
        } catch {
            throw APIError.decoding
        }
    }

    // MARK: - Products (Fake Store)
    func fetchProducts() async throws -> [ProductM] {
        guard let url = URL(string: "https://fakestoreapi.com/products") else { throw APIError.invalidURL }
        let (data, resp) = try await URLSession.shared.data(from: url)
        guard let http = resp as? HTTPURLResponse, 200..<300 ~= http.statusCode else { throw APIError.invalidResponse }
        do {
            return try JSONDecoder().decode([ProductM].self, from: data)
        } catch {
            throw APIError.decoding
        }
    }

    func fetchProductDetail(id: Int) async throws -> ProductM {
        guard let url = URL(string: "https://fakestoreapi.com/products/\(id)") else { throw APIError.invalidURL }
        let (data, resp) = try await URLSession.shared.data(from: url)
        guard let http = resp as? HTTPURLResponse, 200..<300 ~= http.statusCode else { throw APIError.invalidResponse }
        do {
            return try JSONDecoder().decode(ProductM.self, from: data)
        } catch {
            throw APIError.decoding
        }
    }

    // MARK: - Simulated cart calls (network delay)
    func addToCart(product: ProductM, quantity: Int = 1) async throws {
        try await Task.sleep(nanoseconds: 400_000_000) // 0.4s
    }

    func removeFromCart(item: CartItemM) async throws {
        try await Task.sleep(nanoseconds: 300_000_000)
    }
}

