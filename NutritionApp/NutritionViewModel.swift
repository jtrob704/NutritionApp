//
//  NutritionViewModel.swift
//  NutritionApp
//
//  Created by Jaittarius Robinson on 8/18/24.
//

import Foundation

class NutritionViewModel: ObservableObject {
    @Published var responseString: String = ""
    @Published var nutritionRequestLoading: Bool = false
    let webService = WebService()
    let parameters: [String: String] = [
        "upc": "020000111964"
    ]
    
    func makeNutritionRequest() async {
        DispatchQueue.main.async {
            self.nutritionRequestLoading = true
        }
        
        webService.getRequest(urlString: "https://edamam-food-and-grocery-database.p.rapidapi.com/api/food-database/v2/parser", queryParameters: parameters) { data, response, error in
            if let error = error {
                print("GET request failed with error: \(error)")
                DispatchQueue.main.async {
                    self.nutritionRequestLoading = false
                }
                return
            }
            
            if let data = data {
                // Process the received data
                if let responseString = String(data: data, encoding: .utf8) {
                    print("Response data: \(responseString)")
                    DispatchQueue.main.async {
                        self.responseString = responseString
                        self.nutritionRequestLoading = false
                    }
                } else {
                    print("Failed to convert data to string")
                    DispatchQueue.main.async {
                        self.nutritionRequestLoading = false
                    }
                }
            } else {
                print("No data received")
                DispatchQueue.main.async {
                    self.nutritionRequestLoading = false
                }
            }
        }
    }
}
