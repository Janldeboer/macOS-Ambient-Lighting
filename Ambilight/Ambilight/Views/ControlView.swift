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
        let fps = Binding<Double>(get: {
            return manager.interval == 0 ? 0 : 1 / manager.interval
        }, set: {
            manager.interval = $0 == 0 ? 0 : 1 / $0
        })
        VStack {
            GridPreview(splitter: manager.splitter, showIndex: false)
            Button(manager.isRunning ? "Stop" : "Start") {
                manager.isRunning.toggle()
            }
            HStack {
                Text("\(Int(fps.wrappedValue)) FPS")
                Slider(value: fps, in: ClosedRange(uncheckedBounds: (5, 30)))
            }
            Spacer()
            HStack {
                Spacer()
                Text(manager.isRunning ? "\(manager.measuredFPS) FPS" : " ")
            }
        }
    }
}

struct ControlView_Previews: PreviewProvider {
    static var previews: some View {
        ControlView()
            .environmentObject(AmbilightManager())
    }
}

extension Double {
    /// Rounds the double to decimal places value
    func rounded(toPlaces places:Int) -> Double {
        let divisor = pow(10.0, Double(places))
        return (self * divisor).rounded() / divisor
    }
}
