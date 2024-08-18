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
    
    // Function to perform GET request with query parameters
    func getRequest(urlString: String, queryParameters: [String: String]?, completion: @escaping (Data?, URLResponse?, Error?) -> Void) {
        guard var urlComponents = URLComponents(string: urlString) else {
            print("Invalid URL")
            return
        }
        
        // Add query parameters to URL
        if let queryParameters = queryParameters {
            urlComponents.queryItems = queryParameters.map { URLQueryItem(name: $0.key, value: $0.value) }
        }
        
        guard let url = urlComponents.url else {
            print("Failed to construct URL with query parameters")
            return
        }
        
        var request = URLRequest(url: url)
        if let apiKey1 = self.apiKey1 {
            request.setValue(apiKey1, forHTTPHeaderField: "x-rapidapi-key")
        }
        if let apiKey2 = self.apiKey2 {
            request.setValue(apiKey2, forHTTPHeaderField: "x-rapidapi-host")
        }
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            completion(data, response, error)
        }
        task.resume()
    }
    
    // Function to perform POST request using both API keys
    func postRequest(urlString: String, parameters: [String: Any], completion: @escaping (Data?, URLResponse?, Error?) -> Void) {
        guard let url = URL(string: urlString) else {
            print("Invalid URL")
            return
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
        } catch let error {
            print("Error encoding parameters: \(error.localizedDescription)")
            return
        }
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            completion(data, response, error)
        }
        task.resume()
    }
}
