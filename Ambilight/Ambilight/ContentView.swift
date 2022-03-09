//
//  ContentView.swift
//  Ambilight
//
//  Created by Jan de Boer on 08.03.22.
//

import SwiftUI
import CoreData

struct ContentView: View {
    @Environment(\.managedObjectContext) private var viewContext
    
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Item.timestamp, ascending: true)],
        animation: .default)
    private var items: FetchedResults<Item>
    
    let manager = AmbilightManager()
    
    var body: some View {
        TabView(selection: /*@START_MENU_TOKEN@*//*@PLACEHOLDER=Selection@*/.constant(1)/*@END_MENU_TOKEN@*/) {
            ControlView()
                .tabItem { Text("Control") }
                .tag(1)
                .padding()
            SerialPortView()
                .tabItem { Text("Serial Port") }
                .tag(2)
                .padding()
            SourceView(model: SourceViewModel(screenCapture: manager.getScreenCapture()))
                .tabItem { Text("Source") }
                .tag(3)
                .padding()
            Text("Color Correction")
                .tabItem { Text("Color Correction") }
                .tag(4)
                .padding()
        }.padding()
            .environmentObject(manager)
        
    }
    
    private func addItem() {
        withAnimation {
            let newItem = Item(context: viewContext)
            newItem.timestamp = Date()
            saveContext()
        }
    }
    
    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            offsets.map { items[$0] }.forEach(viewContext.delete)
            saveContext()
        }
    }
    
    private func saveContext() {
        do {
            try viewContext.save()
        } catch {
            let nsError = error as NSError
            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
        }
    }
}

private let itemFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateStyle = .short
    formatter.timeStyle = .medium
    return formatter
}()

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
