//
//  WebService.swift
//  NutritionApp
//
//  Created by Jaittarius Robinson on 8/18/24.
//

import Foundation

class WebService {
    private var apiKey1: String?
    private var apiKey2: String?
    
    init() {
        loadApiKeys()
    }
    
    // Function to load API keys from secrets.json
    private func loadApiKeys() {
        guard let url = Bundle.main.url(forResource: "secrets", withExtension: "json") else {
            print("secrets.json file not found")
            return
        }
        
        do {
            let data = try Data(contentsOf: url)
            if let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] {
                self.apiKey1 = json["x-rapidapi-key"] as? String
                self.apiKey2 = json["x-rapidapi-host"] as? String
            }
        } catch {
            print("Error reading secrets.json: \(error.localizedDescription)")
        }
    }
    
    // Async function to perform GET request with query parameters
    func getRequest(urlString: String, queryParameters: [String: String]?) async throws -> Data {
        guard var urlComponents = URLComponents(string: urlString) else {
            throw URLError(.badURL)
        }
        
        // Add query parameters to URL
        if let queryParameters = queryParameters {
            urlComponents.queryItems = queryParameters.map { URLQueryItem(name: $0.key, value: $0.value) }
        }
        
        guard let url = urlComponents.url else {
            throw URLError(.badURL)
        }
        
        var request = URLRequest(url: url)
        if let apiKey1 = self.apiKey1 {
            request.setValue(apiKey1, forHTTPHeaderField: "x-rapidapi-key")
        }
        if let apiKey2 = self.apiKey2 {
            request.setValue(apiKey2, forHTTPHeaderField: "x-rapidapi-host")
        }
        
        let (data, _) = try await URLSession.shared.data(for: request)
        return data
    }
    
    // Async function to perform POST request using both API keys
    func postRequest(urlString: String, parameters: [String: Any]) async throws -> Data {
        guard let url = URL(string: urlString) else {
            throw URLError(.badURL)
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        if let apiKey1 = self.apiKey1 {
            request.setValue(apiKey1, forHTTPHeaderField: "x-rapidapi-key")
        }
        if let apiKey2 = self.apiKey2 {
            request.setValue(apiKey2, forHTTPHeaderField: "x-rapidapi-host")
        }
        
        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: parameters, options: .prettyPrinted)
        } catch {
            throw URLError(.cannotDecodeContentData)
        }
        
        let (data, _) = try await URLSession.shared.data(for: request)
        return data
    }
}
