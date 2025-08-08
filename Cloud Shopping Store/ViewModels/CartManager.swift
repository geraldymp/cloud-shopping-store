//
//  CartManager.swift
//  Cloud Shopping Store
//
//  Created by Geraldy on 07/08/25.
//
import Foundation
import Combine

class CartManager: ObservableObject {
    @Published var items: [Product] = []
    
    var totalPrice: Double {
        items.reduce((0)) { res, item in
            res + item.price
        }
    }
    
    func add(product: Product) {
        items.append(product)
    }
    
    func remove(product: Product) {
        items.removeAll { item in
            item.id == product.id
        }
    }
    
    func removeAll() {
        items.removeAll()
    }
}
