//
//  CartView.swift
//  Cloud Shopping Store
//
//  Created by Geraldy on 07/08/25.
//
import SwiftUI

struct CartView: View {
    
    @EnvironmentObject var cart: CartManager
    
    var body: some View {
        VStack(spacing: 12) {
                    if cart.items.isEmpty {
                        Spacer()
                        Text("Your cart is empty.")
                            .font(.headline)
                            .foregroundColor(.gray)
                        Spacer()
                    } else {
                        ScrollView {
                            VStack(spacing: 16) {
                                ForEach(cart.items) { item in
                                    CartCardView(
                                        product: item,
                                        onRemove: {
                                            cart.remove(product: item)
                                        }
                                    )
                                }
                            }
                            .padding()
                        }
                    }

                    // Sticky bottom bar
                    HStack {
                        Text("Total: $\(cart.totalPrice, specifier: "%.2f")")
                            .font(.headline)
                        Spacer()
                        Button(action: {
                            // TODO: Handle checkout
                        }) {
                            Text("Buy")
                                .foregroundColor(.white)
                                .padding(.horizontal, 24)
                                .padding(.vertical, 10)
                                .background(Color.blue)
                                .cornerRadius(10)
                        }
                    }
                    .padding()
                    .background(.ultraThinMaterial)
                }
                .navigationTitle("Cart")
    }
}
