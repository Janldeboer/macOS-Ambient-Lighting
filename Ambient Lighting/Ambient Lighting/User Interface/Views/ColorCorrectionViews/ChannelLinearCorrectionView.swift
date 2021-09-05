//
//  ChannelLinearCorrectionView.swift
//  Ambient Lighting
//
//  Created by Jan de Boer on 05.09.21.
//

import SwiftUI

struct ChannelLinearCorrectionView: View {
    
    @Binding var correction: ChannelLinearCorrection
    
    var body: some View {
        VStack {
            Text("Channel Linear Correction")
                .font(.title2)

            HStack {
                VStack {
                    Spacer()
                    Text("Red \(correction.strength.red)")
                    Spacer()
                    Text("Green \(correction.strength.green)")
                    Spacer()
                    Text("Blue \(correction.strength.blue)")
                    Spacer()
                }
                VStack {
                    Slider(value: $correction.strength.red, in: ClosedRange(uncheckedBounds: (0,1)))
                    Slider(value: $correction.strength.green, in: ClosedRange(uncheckedBounds: (0,1)))
                    Slider(value: $correction.strength.blue, in: ClosedRange(uncheckedBounds: (0,1)))
                }
            }
        }
    }
}

struct ChannelLinearCorrectionView_Previews: PreviewProvider {
    static var previews: some View {
        ChannelLinearCorrectionView(correction: .constant(ChannelLinearCorrection(strength: RGB(0.8, 0.4, 0.3))))
    }
}
