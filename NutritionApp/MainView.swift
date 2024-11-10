//
//  MainView.swift
//  NutritionApp
//
//  Created by J.T. Robinson on 11/10/24.
//

import SwiftUI

struct MainView: View {
    var body: some View {
        TabView {
            ContentView()
                .tabItem {
                    Label("Lookup", systemImage: "magnifyingglass")
                }
            ScanView()
                .tabItem {
                    Label("Scan", systemImage: "barcode.viewfinder")
                }
        }
    }
}
