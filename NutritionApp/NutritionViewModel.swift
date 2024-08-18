//
//  NutritionViewModel.swift
//  NutritionApp
//
//  Created by Jaittarius Robinson on 8/18/24.
//

import Foundation

class NutritionViewModel: ObservableObject {
    @Published var testText: String = "Hello World!"
    @Published var responseString: String = ""
    let webService = WebService()
    let parameters: [String: String] = [
        "upc": "020000111964"
    ]
    
    func makeNutritionRequest() async -> Void {
        webService.getRequest(urlString: "https://edamam-food-and-grocery-database.p.rapidapi.com/api/food-database/v2/parser", queryParameters: parameters) { data, response, error in
            if let error = error {
                print("GET request failed with error: \(error)")
                return
            }
            
            if let data = data {
                // Process the received data
                if let responseString = String(data: data, encoding: .utf8) {
                    print("Response data: \(responseString)")
                } else {
                    print("Failed to convert data to string")
                }
            } else {
                print("No data received")
            }
        }
    }
}
