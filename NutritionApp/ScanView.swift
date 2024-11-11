//
//  ScanView.swift
//  NutritionApp
//
//  Created by J.T. Robinson on 11/10/24.
//

import SwiftUI
import CodeScanner

struct ScanView: View {
    @State private var isPresentingScanner = false
    @State private var scannedCode: String?
    @State private var upcCodeArr: [String] = []
    
    var body: some View {
        VStack(spacing: 10) {
            ForEach(upcCodeArr, id: \.self) { upcCode in
                Text("\(upcCode)")
            }
            Button("Scan Code") {
                isPresentingScanner = true
            }.buttonStyle(.bordered)
                .sensoryFeedback(.success, trigger: scannedCode)
            
            Text("Scan a UPC code to begin")
        }
        .sheet(isPresented: $isPresentingScanner) {
            HStack {
                Spacer()
                Button("Done") {
                    isPresentingScanner = false
                }.padding()
            }
            CodeScannerView(codeTypes: [.ean13], scanMode: .oncePerCode, showViewfinder: true) { response in
                if case let .success(result) = response {
                    scannedCode = String(result.string.dropFirst(1))
                    upcCodeArr.append(scannedCode!)
                }
            }
        }
    }
}

#Preview {
    ScanView()
}
