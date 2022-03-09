//
//  ControlView.swift
//  Ambilight
//
//  Created by Jan de Boer on 08.03.22.
//

import SwiftUI

struct ControlView: View {
    
    @StateObject var model: ControlViewModel = ControlViewModel()
    @EnvironmentObject var manager: AmbilightManager
    
    var body: some View {
        Button(manager.isRunning ? "Stop" : "Start") {
            manager.isRunning.toggle()
        }
    }
}

struct ControlView_Previews: PreviewProvider {
    static var previews: some View {
        ControlView()
            .environmentObject(AmbilightManager())
    }
}
