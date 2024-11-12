//
//  NutritionViewModel.swift
//  NutritionApp
//
//  Created by Jaittarius Robinson on 8/18/24.
//

import Foundation
import Observation

@Observable
class NutritionViewModel {
    var responseString: String = ""
    var nutritionRequestLoading: Bool = false
    var nutritionApiResults: NutritionRequestResponse?
    let webService = WebService()
    let parameters: [String: String] = [
        "upc": "020000111964"
    ]
    
    func makeNutritionRequest() async {
        self.nutritionRequestLoading = true
        
        do {
            let data = try await webService.getRequest(
                urlString: "https://edamam-food-and-grocery-database.p.rapidapi.com/api/food-database/v2/parser",
                queryParameters: parameters
            )
            
            self.nutritionApiResults = try JSONDecoder().decode(NutritionRequestResponse.self, from: data)
            print("NutritionRequestResponse \(self.nutritionApiResults)")
        } catch {
            print("Request failed with error: \(error.localizedDescription)")
        }
        
        self.nutritionRequestLoading = false
    }
}
