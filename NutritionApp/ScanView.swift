//
//  ScanView.swift
//  NutritionApp
//
//  Created by J.T. Robinson on 11/10/24.
//

import SwiftUI
import CodeScanner

struct ScanView: View {
    var body: some View {
        CodeScannerView(codeTypes: [.ean13], showViewfinder: true, simulatedData: "123456789", shouldVibrateOnSuccess: true) { response in
            switch response {
            case .success(let result):
                print("Found code: \(result.string.dropFirst(1))")
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}

#Preview {
    ScanView()
}
