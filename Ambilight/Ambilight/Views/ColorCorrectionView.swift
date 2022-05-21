//
//  ColorCorrectionView.swift
//  Ambilight
//
//  Created by Jan de Boer on 09.03.22.
//

import SwiftUI

struct ColorCorrectionView: View {
    
    @EnvironmentObject var manager: AmbilightManager
    
    var body: some View {
        List {
            ForEach(manager.corrector.correctors.indices) { i in
                if let c = manager.corrector.correctors[i] as? ChannelColorCorrection {
                    let binding: Binding<ChannelColorCorrection> = Binding(get: {
                        return c
                    }, set: {
                        manager.corrector.correctors[i] = $0
                    })
                    ChannelCorrectionView(correction: binding)
                }
                if let c = manager.corrector.correctors[i] as? SaturationCorrection {
                    let binding: Binding<SaturationCorrection> = Binding(get: {
                        return c
                    }, set: {
                        manager.corrector.correctors[i] = $0
                    })
                    SaturationCorrectionView(correction: binding)
                }
            }
        }
    }
}

struct ChannelCorrectionView: View {
    
    @Binding var correction: ChannelColorCorrection
    
    var body: some View {
        VStack {
            Text(correction.scaler.name)
                .font(.title)
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

struct SaturationCorrectionView: View {
    
    @Binding var correction: SaturationCorrection
    
    var body: some View {
        VStack {
            HStack {
                Text("Gamma \(correction.gamma)")
                Slider(value: $correction.gamma, in: ClosedRange(uncheckedBounds: (0,1)))
            }
        }
    }
}

struct ColorCorrectionView_Previews: PreviewProvider {
    static var previews: some View {
        ColorCorrectionView()
    }
}
