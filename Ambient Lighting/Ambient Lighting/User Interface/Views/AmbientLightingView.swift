//
//  AmbientLightingView.swift
//  Ambient Lighting
//
//  Created by Jan de Boer on 04.09.21.
//

import SwiftUI

struct AmbientLightingView: View {
    
    @StateObject var model: AmbientLightingModel = AmbientLightingModel()
    
    var body: some View {
        ScrollView {
        VStack {
            ImageSourceView(imageSource: $model.source)
            ImageSplitterView(splitter: $model.splitter)
            LightOutputView(output: $model.output)
            
            Button(action: {
                model.isRunning = !model.isRunning
            }, label: {
                Text(model.isRunning ? "Stop" : "Start")
            })
            
        }.environmentObject(model)
            .padding()
        }
    }
}

struct AmbientLightingView_Previews: PreviewProvider {
    static var previews: some View {
        AmbientLightingView()
    }
}
