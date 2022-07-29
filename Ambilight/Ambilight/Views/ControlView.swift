//
//  ControlView.swift
//  Ambilight
//
//  Created by Jan de Boer on 08.03.22.
//

import SwiftUI

struct ControlView: View {
    
    @StateObject var zeitgeber: Zeitgeber
    
    var body: some View {
        VStack {
            //GridPreview(splitter: manager.splitter, showIndex: false)
            Button(zeitgeber.isRunning ? "Stop" : "Start") {
                zeitgeber.isRunning.toggle()
            }
            HStack {
                Text("\(Int(zeitgeber.fps)) FPS")
                Slider(value: $zeitgeber.fps, in: ClosedRange(uncheckedBounds: (5, 30)))
            }
            Spacer()
            HStack {
                Spacer()
                Text(zeitgeber.isRunning ? "\(zeitgeber.measuredFPS) FPS" : " ")
            }
        }
    }
}

struct ControlView_Previews: PreviewProvider {
    static var previews: some View {
        ControlView(zeitgeber: Zeitgeber())
    }
}

extension Double {
    /// Rounds the double to decimal places value
    func rounded(toPlaces places:Int) -> Double {
        let divisor = pow(10.0, Double(places))
        return (self * divisor).rounded() / divisor
    }
}
