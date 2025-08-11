//
//  ProductViewModel.swift
//  Cloud Shopping Store
//
//  Created by Geraldy on 06/08/25.
//

import Foundation
import Combine

class ProductViewModel: ObservableObject {
    @Published var products: [Product] = []
    @Published var isLoading = false
    @Published var errorMessage: String?
    
    @Published var categories: [Category] = []
    @Published var selectedCategory: Category? = nil
    
    @Published var selectedSort: Sort? = nil
    let sortType = "title"

    private let categoriesURL = URL(string: "https://dummyjson.com/products/categories")!

    func fetchProducts() {
        let baseUrl = "https://dummyjson.com/products"
        var urlString = baseUrl
        if (selectedCategory != nil) {
            urlString = "\(baseUrl)/category/\(selectedCategory!.slug)"
        }
        
        var components = URLComponents(string: urlString)
        
        var queryItems: [URLQueryItem] = []
        
        if (selectedSort != nil) {
            queryItems.append(URLQueryItem(name: "sortBy", value: selectedSort?.sortBy))
            queryItems.append(URLQueryItem(name: "order", value: selectedSort?.order))
        }
        
        if !queryItems.isEmpty {
                components?.queryItems = queryItems
            }
        
        guard let url = components?.url else { return }
        
        isLoading = true
        errorMessage = nil

        URLSession.shared.dataTask(with: url) { data, response, error in
            DispatchQueue.main.async {
                self.isLoading = false
                print(url)

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
        }
        .resume()
    }
    
    func fetchCategories() {
        URLSession.shared.dataTask(with: categoriesURL) { data, response, error in
            DispatchQueue.main.async {
                do {
                    let decoded = try JSONDecoder().decode([Category].self, from: data!)
                    self.categories = decoded
                } catch {
                    return
                }
            }
            
        }
        .resume()
    }
}

