//  FruitService.swift
//  FruitList2026

import Foundation

class FruitService {
    static let shared = FruitService()
    
    func fetchFruits() async throws -> [Fruit] {
        // Live API endpoint for all fruits
        guard let url = URL(string: "https://www.fruityvice.com/api/fruit/all") else {
            throw URLError(.badURL)
        }
        
        let (data, response) = try await URLSession.shared.data(from: url)
        
        guard let httpResponse = response as? HTTPURLResponse,
                200..<300 ~= httpResponse.statusCode else {
            throw URLError(.badServerResponse)
        }
        
        let decoder = JSONDecoder()
        
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        return try decoder.decode([Fruit].self, from: data)
    }
}
