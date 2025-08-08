//
//  ProductDetailView.swift
//  Cloud Shopping Store
//
//  Created by Geraldy on 07/08/25.
//
import SwiftUI

struct ProductDetailView: View {

    let product: Product

    @EnvironmentObject var cart: CartManager
    @State private var showToast: Bool = false

    var body: some View {
        VStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 16) {
                    AsyncImage(url: URL(string: product.thumbnail)) { phase in
                        switch phase {
                        case .empty:
                            Color.gray.opacity(0.1)
                        case .success(let image):
                            image
                                .resizable()
                                .scaledToFit()
                        case .failure:
                            Image(systemName: "xmark.octagon")
                        @unknown default:
                            EmptyView()
                        }
                    }
                    .frame(height: 400)
                    .frame(maxWidth: .infinity)
                    .background(Color.gray.opacity(0.05))
                    .cornerRadius(12)
                    .overlay(
                        RoundedRectangle(cornerRadius: 12)
                            .stroke(Color.red)
                    )

                    Text(product.title)
                        .font(.title2)
                        .fontWeight(.bold)
                        .foregroundColor(.primary)

                    Text("$\(String(format: "%.2f", product.price))")
                        .font(.title3)
                        .foregroundColor(.green)

                    HStack(spacing: 4) {
                        Image(systemName: "star.fill")
                            .foregroundColor(.yellow)
                        Text(String(format: "%.1f", product.rating))
                            .foregroundColor(.secondary)
                    }

                    Text(product.description)
                        .font(.body)
                        .foregroundColor(.secondary)
                }
                .padding()
            }

            HStack(spacing: 12) {
                Button {
                    cart.add(product: product)
                    showToast = true

                        // Hide after delay
                        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                            showToast = false
                        }
                } label: {
                    Text("Add to Cart")
                        .fontWeight(.semibold)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.gray.opacity(0.2))
                        .foregroundStyle(.primary)
                        .cornerRadius(8)
                }

                Button {
                    print("Buy Tapped")
                } label: {
                    Text("Buy Now")
                        .fontWeight(.semibold)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.blue)
                        .foregroundStyle(.white)
                        .cornerRadius(8)
                }

            }
            .padding()
            .background(.ultraThinMaterial)
        }
        .overlay(
            Group {
                if showToast {
                    Text("Added to cart!")
                        .padding(.horizontal, 20)
                        .padding(.vertical, 10)
                        .background(Color.black.opacity(0.8))
                        .foregroundColor(.white)
                        .cornerRadius(12)
                        .transition(
                            .move(edge: .bottom).combined(with: .opacity)
                        )
                        .animation(.easeInOut, value: showToast)
                        .padding(.bottom, 40)
                }
            }
        )
        .navigationTitle("Product Detail")
        .navigationBarTitleDisplayMode(.inline)
    }
}
