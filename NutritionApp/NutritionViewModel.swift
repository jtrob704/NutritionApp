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
    @Published var nutritionApiResults: NutritionRequestResponse?
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
                DispatchQueue.main.async {
                    do {
                        self.nutritionApiResults = try JSONDecoder().decode(NutritionRequestResponse.self, from: data)
                        print("NutritionRequestResponse \(self.nutritionApiResults)")
                        self.nutritionRequestLoading = false
                    } catch {
                        print("Failed to decode JSON: \(error.localizedDescription)")
                        self.nutritionRequestLoading = false
                    }
                }
            }
            //            if let data = data {
            //                // Process the received data
            //                DispatchQueue.main.async {
            //                print("Response data: \(self.responseString)")
            //                        self.responseString = self.responseString
            //                        self.nutritionRequestLoading = false
            //                    }
            ////                } else {
            ////                    print("Failed to convert data to string")
            ////                    DispatchQueue.main.async {
            ////                        self.nutritionRequestLoading = false
            ////                    }
            ////                }
            //            } else {
            //                print("No data received")
            //                DispatchQueue.main.async {
            //                    self.nutritionRequestLoading = false
            //                }
            //            }
        }
    }
}
