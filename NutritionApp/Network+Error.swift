//
//  Network+Error.swift
//  NutritionApp
//
//  Created by Jaittarius Robinson on 8/18/24.
//

enum NetworkError: Error {
    case badUrl
    case invalidRequest
    case badResponse
    case badStatus
    case failedToDecodeResponse
}
