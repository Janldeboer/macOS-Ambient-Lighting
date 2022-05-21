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
    
    @State var tab = 0
    
    let manager = AmbilightManager()
    
    var body: some View {
        TabView(selection: $tab) {
            ControlView()
                .tag(0)
                .tabItem { Text("Control") }
                .padding()
            SourceView(model: SourceViewModel(screenCapture: manager.getScreenCapture()))
                .tag(1)
                .tabItem { Text("Source") }
                .padding()
            SplitterView(splitter: manager.getGridSplitter())
                .tag(2)
                .tabItem { Text("Splitter") }
                .padding()
            Text("Reducer")
                .tag(3)
                .tabItem { Text("Reducer") }
                .padding()
            ColorCorrectionView()
                .tag(4)
                .tabItem { Text("Color Correction") }
                .padding()
            SerialPortView()
                .tag(5)
                .tabItem { Text("Serial Port") }
                .padding()
        }.padding()
            .environmentObject(manager)
        
    }
}

extension NSManagedObjectContext {
    func protecedSave() {
        do {
            try save()
        } catch {
            let nsError = error as NSError
            print("Unresolved error \(nsError), \(nsError.userInfo)")
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
