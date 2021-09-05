//
//  ColorCorrectionView.swift
//  Ambient Lighting
//
//  Created by Jan de Boer on 29.08.21.
//

import SwiftUI

struct ColorCorrectionView: View {
    
    @Binding var correction: ColorCorrection
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 20
            )
                .shadow(radius: 10)
                .foregroundColor(.init(red: 0.3, green: 0.3, blue: 0.3))
            switch correction {
            case is ChannelLinearCorrection:
                let bind = Binding<ChannelLinearCorrection>(get: { correction as! ChannelLinearCorrection}, set: { correction = $0})
                ChannelLinearCorrectionView(correction: bind)
                    .padding()
            case is SaturationCorrection:
                let bind = Binding<SaturationCorrection>(get: { correction as! SaturationCorrection}, set: { correction = $0})
                SaturationCorrectionView(correction: bind)
                    .padding()
            case is ChainedColorCorrection:
                let bind = Binding<ChainedColorCorrection>(get: { correction as! ChainedColorCorrection}, set: { correction = $0})
                ChainedCorrectionView(correction: bind)
                    .padding()
            default:
                Text("This Correction isn't supported by the GUI")
                    .padding()
            }
        }
    }
}

struct ColorCorrectionSetupView_Previews: PreviewProvider {
    static var previews: some View {
        ColorCorrectionView(correction: .constant(ChainedColorCorrection(correctors: [ChannelGammaCorrection(strength: RGB(0.8, 0.2, 0.4))])))
    }
}
