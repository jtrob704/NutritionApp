//
//  NutritionAppApp.swift
//  NutritionApp
//
//  Created by Jaittarius Robinson on 8/18/24.
//

import SwiftUI

@main
struct NutritionAppApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            MainView()
                .environment(NutritionViewModel())
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
