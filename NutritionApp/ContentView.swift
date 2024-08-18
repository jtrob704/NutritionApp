//
//  ContentView.swift
//  NutritionApp
//
//  Created by Jaittarius Robinson on 8/18/24.
//

import SwiftUI
import CoreData

struct ContentView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @EnvironmentObject var viewModel: NutritionViewModel
    
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Item.timestamp, ascending: true)],
        animation: .default)
    private var items: FetchedResults<Item>
    
    var body: some View {
        NavigationView {
            Spacer()
            if viewModel.nutritionRequestLoading {
                ProgressView()
            } else {
                Button("Retrieve Data", action: {
                    Task { await viewModel.makeNutritionRequest() }
                })
                .buttonStyle(.bordered)
                Text(viewModel.nutritionApiResults?.text ?? "")
                Text(viewModel.nutritionApiResults?.hints?[0].food?.label ?? "")
//                AsyncImage(url: URL(string: viewModel.nutritionApiResults?.hints?[0].food?.image ?? ""))
            }
            Spacer()
            //            List {
            //                Text(viewModel.testText)
            //                ForEach(items) { item in
            //                    NavigationLink {
            //                        Text("Item at \(item.timestamp!, formatter: itemFormatter)")
            //                    } label: {
            //                        Text(item.timestamp!, formatter: itemFormatter)
            //                    }
            //                }
            //                .onDelete(perform: deleteItems)
            //            }
            //            .toolbar {
            //                ToolbarItem(placement: .navigationBarTrailing) {
            //                    EditButton()
            //                }
            //                ToolbarItem {
            //                    Button(action: addItem) {
            //                        Label("Add Item", systemImage: "plus")
            //                    }
            //                }
            //            }
            //            Text("Select an item")
            //            }
        }
    }
    
    private func addItem() {
        withAnimation {
            let newItem = Item(context: viewContext)
            newItem.timestamp = Date()
            
            do {
                try viewContext.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }
    
    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            offsets.map { items[$0] }.forEach(viewContext.delete)
            
            do {
                try viewContext.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }
}

private let itemFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateStyle = .short
    formatter.timeStyle = .medium
    return formatter
}()

//#Preview {
//    var viewModel: NutritionViewModel
//    ContentView()
//        .environmentObject(NutritionViewModel())
//        .environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
//}
