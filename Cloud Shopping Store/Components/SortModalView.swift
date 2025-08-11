//
//  SortModalView.swift
//  Cloud Shopping Store
//
//  Created by Geraldy on 08/08/25.
//
import SwiftUI

struct SortModalView: View {
    let sorts: [Sort] = [
        Sort(name: "Title ASC", sortBy: "title", order: "asc"),
        Sort(name: "Title DSC", sortBy: "title", order: "desc"),
        Sort(name: "Price ASC", sortBy: "price", order: "asc"),
        Sort(name: "Price DSC", sortBy: "price", order: "desc"),
        Sort(name: "Rating ASC", sortBy: "rating", order: "asc"),
        Sort(name: "Rating DSC", sortBy: "rating", order: "desc")
    ]
    @Binding var selectedSort: Sort?
    let onSelect: () -> Void
    @Environment(\.dismiss) var dismiss
    
    let column = [
        GridItem(.flexible())
    ]

    func onSelectSort(_ sort: Sort) {
        selectedSort = sort
        onSelect()
        dismiss()
    }

    var body: some View {
        NavigationView {
            ScrollView {
                LazyVGrid(columns: column) {
                    ForEach(sorts, id: \.self) { sort in
                        Button {
                            onSelectSort(sort)
                        } label: {
                            HStack {
                                Text(sort.name)
                                Spacer()
                                if (selectedSort?.name == sort.name) {
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

