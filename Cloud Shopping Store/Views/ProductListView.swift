//
//  ProductListView.swift
//  Cloud Shopping Store
//
//  Created by Geraldy on 06/08/25.
//

import SwiftUI

struct ProductListView: View {

    @StateObject var viewModel = ProductViewModel()
    @State private var showFilterView = false
    @State private var showSortView = false

    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible()),
    ]

    var body: some View {
        NavigationView {
            VStack {
                Spacer()
                HStack {
                    Button {
                        showFilterView = true
                    } label: {
                        Text("Filter")
                    }
                    .padding(.horizontal, 16)
                    
                    Spacer()

                    Button {
                        showSortView = true
                    } label: {
                        Text("Sort")
                    }
                    .padding(.horizontal, 16)
                }
                ScrollView {
                    if viewModel.isLoading {
                        ProgressView("Loading Products...")
                    } else if let errorMessage = viewModel.errorMessage {
                        Text("Error: \(errorMessage)")
                    } else {
                        LazyVGrid(columns: columns, spacing: 16) {
                            ForEach(viewModel.products) { product in
                                NavigationLink(
                                    destination: ProductDetailView(
                                        product: product
                                    )
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
                    viewModel.fetchCategories()
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
            .sheet(isPresented: $showFilterView) {
                CategoryModalView(categories: viewModel.categories, selectedCategory: $viewModel.selectedCategory, onSelect: viewModel.fetchProducts
                )
                    .interactiveDismissDisabled(true)
                    .highPriorityGesture(DragGesture())
            }
            .sheet(isPresented: $showSortView) {
                SortModalView(selectedSort: $viewModel.selectedSort, onSelect: viewModel.fetchProducts)
                    .interactiveDismissDisabled()
                    .highPriorityGesture(DragGesture())
            }
        }
    }
}

#Preview {
    ProductListView()
        .environmentObject(CartManager())
}
