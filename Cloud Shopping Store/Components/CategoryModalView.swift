//
//  CategoryModalView.swift
//  Cloud Shopping Store
//
//  Created by Geraldy on 08/08/25.
//
import SwiftUI

struct CategoryModalView: View {
    let categories: [Category]
    @Binding var selectedCategory: Category?
    let onSelect: () -> Void
    @Environment(\.dismiss) var dismiss
    
    let column = [
        GridItem(.flexible())
    ]

    func onSelectCategory(_ category: Category) {
        selectedCategory = category
        onSelect()
        dismiss()
    }

    var body: some View {
        NavigationView {
            ScrollView {
                LazyVGrid(columns: column) {
                    ForEach(categories, id: \.self) { category in
                        Button {
                            onSelectCategory(category)
                        } label: {
                            HStack {
                                Text(category.name)
                                Spacer()
                                if selectedCategory?.name == category.name {
                                    Image(systemName: "checkmark")
                                        .foregroundColor(.blue)
                                }
                            }
                        }
                        .padding()
                        .background(Color.white)
                        .border(Color.gray)
                    }
                }
            }
            .scrollIndicators(.never)
            .padding()
            .navigationTitle("Select Category")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}
