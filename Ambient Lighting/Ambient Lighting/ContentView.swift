//
//  ContentView.swift
//  Ambient Lighting
//
//  Created by Jan de Boer on 25.03.21.
//

import SwiftUI
/*
struct ContentView: View {
    var timer = Timer.publish(every: 0.04, on: .main, in: .common).autoconnect()
    var runner = AmbientLightingRunner()
    
    
    init() {
        runner.isRunning = true
    }
    
    var body: some View {
        VStack {
            SerialSettingsView()
            GridSplitterView()
                .onReceive(timer, perform: { _ in
                    if serialSettingsModel.isRunning {
                        gridModel.refreshOutput(withImage: imageSourceModel.imageSource.getImage())
                    }
                })
        }
        .environmentObject(imageSourceModel)
        .environmentObject(serialSettingsModel)
        .environmentObject(gridModel)
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}*/
