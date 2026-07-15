//  ContentView.swift
//  FruitList2026

import SwiftUI

struct ContentView: View {
    @State private var fruits: [Fruit] = []
    @State private var searchText = ""
    @State private var isLoading = true
    @State private var errorMessage: String?
    
    // Filtered list based on search text
    var filteredFruits: [Fruit] {
        if searchText.isEmpty {
            return fruits
        } else {
            return fruits.filter { $0.name.localizedCaseInsensitiveContains(searchText) }
        }
    }
    
    var body: some View {
        NavigationStack {
            Group {
                if isLoading {
                    ProgressView("Loading Fruits...")
                } else if let errorMessage = errorMessage {
                    Text("Error: \(errorMessage)")
                        .foregroundColor(.red)
                        .multilineTextAlignment(.center)
                        .padding()
                } else {
                    List(filteredFruits) { fruit in
                        NavigationLink(value: fruit) {
                            Text(fruit.name)
                                .font(.headline)
                        }
                    }
                    .navigationDestination(for: Fruit.self) { fruit in
                        FruitDetailView(fruit: fruit)
                    }
                    .searchable(text: $searchText, placement: .navigationBarDrawer(displayMode: .always), prompt: "Search fruits")
                }
            }
            .navigationTitle("Fruits")
            .task {
                await loadFruits()
            }
        }
    }
    
    func loadFruits() async {
        do {
            fruits = try await FruitService.shared.fetchFruits()
            isLoading = false
        } catch {
            errorMessage = error.localizedDescription
            isLoading = false
        }
    }
}

#Preview {
    ContentView()
}
