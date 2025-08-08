//
//  Cloud_Shopping_StoreApp.swift
//  Cloud Shopping Store
//
//  Created by Geraldy on 06/08/25.
//

import SwiftUI

@main
struct Cloud_Shopping_StoreApp: App {
    
    @StateObject private var cartManager = CartManager()
    
    var body: some Scene {
        WindowGroup {
            ProductListView()
                .environmentObject(cartManager)
        }
    }
}
