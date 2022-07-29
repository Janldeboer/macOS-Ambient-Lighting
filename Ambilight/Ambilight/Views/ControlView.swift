//
//  ControlView.swift
//  Ambilight
//
//  Created by Jan de Boer on 08.03.22.
//

import SwiftUI

struct ControlView: View {
    
    @StateObject var model: ControlViewModel = ControlViewModel()
    
    var body: some View {
        VStack {
            //GridPreview(splitter: manager.splitter, showIndex: false)
            Button(model.isRunning ? "Stop" : "Start") {
                model.isRunning.toggle()
            }
            HStack {
                Text("\(Int(model.fps)) FPS")
                Slider(value: $model.fps, in: ClosedRange(uncheckedBounds: (5, 30)))
            }
            Spacer()
            HStack {
                Spacer()
                Text(model.isRunning ? "\(model.measuredFPS) FPS" : " ")
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
