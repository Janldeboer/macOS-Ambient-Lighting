//
//  SaturationCorrectionView.swift
//  Ambient Lighting
//
//  Created by Jan de Boer on 01.09.21.
//

import SwiftUI

struct SaturationCorrectionView: View {
    
    @Binding var correction: SaturationCorrection
    
    var body: some View {
        VStack {
            Text("Saturation Correction")
                .font(.title2)
            HStack {
                Text("Saturation \(correction.gamma)")
                Slider(value: $correction.gamma, in: ClosedRange(uncheckedBounds: (0,1)))
            }
        }
    }
}

struct SaturationCorrectionView_Previews: PreviewProvider {
    static var previews: some View {
        SaturationCorrectionView(correction: .constant(SaturationCorrection(gamma: 0.5)))
    }
}
