//
//  ProductListView.swift
//  Cloud Shopping Store
//
//  Created by Geraldy on 06/08/25.
//

import SwiftUI

struct ProductListView: View {

    @StateObject var viewModel = ProductViewModel()

    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible()),
    ]

    var body: some View {
        NavigationView {
            ScrollView {
                if viewModel.isLoading {
                    ProgressView("Loading Products...")
                } else if let errorMessage = viewModel.errorMessage {
                    Text("Error: \(errorMessage)")
                } else {
                    LazyVGrid(columns: columns, spacing: 16) {
                        ForEach(viewModel.products) { product in
                            NavigationLink(
                                destination: ProductDetailView(product: product)
                            ) {
                                ProductCardView(product: product)
                            }
                        }
                    }
                    .padding(8)
                }
            }
            .navigationTitle("Products")
            .onAppear {
                viewModel.fetchProducts()
            }
            .overlay {
                VStack {
                    Spacer()
                    HStack {
                        Spacer()
                        NavigationLink(destination: CartView()) {
                            Image(systemName: "cart.fill")
                                .font(.system(size: 24))
                                .foregroundColor(.white)
                                .padding()
                                .background(Color.blue)
                                .clipShape(Circle())
                                .shadow(radius: 4)
                        }

                    }

                }
                .padding()

            }
        }
    }
}

#Preview {
    ProductListView()
        .environmentObject(CartManager())
}
