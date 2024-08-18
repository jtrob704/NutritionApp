//
//  NutritionRequestResponse.swift
//  NutritionApp
//
//  Created by Jaittarius Robinson on 8/18/24.
//

import Foundation

struct NutritionRequestResponse: Codable {
    let text: String?
    let hints: [Hint]?
}

struct Hint: Codable {
    let food: Food?
    // Include other properties of the hint here as per the actual API response
}

struct Food: Codable {
    let label: String?
    let nutrients: Nutrients?
    let image: String?
    // Include other properties of the food here as per the actual API response
}

struct Nutrients: Codable {
    let calories: Double?
    let protein: Double?
    // Include other nutrients here as per the actual API response
}
