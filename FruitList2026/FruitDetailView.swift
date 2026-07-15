//  FruitDetailView.swift
//  FruitList2026

import SwiftUI

struct FruitDetailView: View {
    
    let fruit: Fruit
    
    var body: some View {
        VStack(spacing: 15) {
            Text(fruit.name)
                .font(.largeTitle)
                .bold()
            
            Text("Family: \(fruit.family)")
            Text("Order: \(fruit.order)")
            
            if let nutrition = fruit.nutritions {
                Text("Calories: \(nutrition.calories)")
                Text("Carbs: \(nutrition.carbohydrates)g, Protein: \(nutrition.protein)g, Fat: \(nutrition.fat)g, Sugar: \(nutrition.sugar)g")
                    .font(.subheadline)
                    .multilineTextAlignment(.center)
                
                
            }
            Spacer()
        }
        .padding()
        .navigationTitle(fruit.name)
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    FruitDetailView(fruit: Fruit(
        name: "Apple",
        family: "Rosaceae",
        order: "Rosales",
        nutritions: Nutrition(carbohydrates: 22, protein: 5, fat: 3 , calories: 100, sugar: 17.2)
    ))
}
