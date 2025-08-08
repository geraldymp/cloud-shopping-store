//
//  ProductViewModel.swift
//  Cloud Shopping Store
//
//  Created by Geraldy on 06/08/25.
//

import Foundation
import Combine

//struct Product: Codable, Identifiable {
//    let id: Int
//    let title: String
//    let price: Double
//    let description: String
//    let category: String
//    let image: String
//}
struct QuestionsResponse: Codable {
    let results: [Question]
}

struct Question: Codable, Identifiable {
    var id: UUID { UUID() }
    let category: String
    let difficulty: String
    let question: String
    let correct_answer: String
}

class ProductViewModel: ObservableObject {
//    @Published var products: [Question] = []
    @Published var products: [Product] = []
    @Published var isLoading = false
    @Published var errorMessage: String?

//    private let url = URL(string: "https://opentdb.com/api.php?amount=10&category=9&type=boolean")!
    private let url = URL(string: "https://dummyjson.com/products")!

    func fetchProducts() {
        isLoading = true
        errorMessage = nil

        URLSession.shared.dataTask(with: url) { data, response, error in
            DispatchQueue.main.async {
                self.isLoading = false
                

                if let error = error {
                    self.errorMessage = "❌ \(error.localizedDescription)"
                    return
                }

                guard let data = data else {
                    self.errorMessage = "❌ No data received."
                    return
                }

                do {
                    let decoded = try JSONDecoder().decode(Products.self, from: data)
                    self.products = decoded.products
                } catch {
                    self.errorMessage = "❌ Failed to decode: \(error.localizedDescription)"
                }
            }
        }.resume()
    }
}

