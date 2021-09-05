//
//  ChainedCorrectionView.swift
//  Ambient Lighting
//
//  Created by Jan de Boer on 05.09.21.
//

import SwiftUI

struct ChainedCorrectionView: View {
    
    @Binding var correction: ChainedColorCorrection
    
    init (correction: Binding<ChainedColorCorrection>) {
        self._correction = correction
        print(correction.correctors.count)
    }
    
    var body: some View {
        VStack {
            DisclosureGroup(content: {
                ForEach($correction.correctors, id:\.id) { $corrector in
                    ZStack {
                        ColorCorrectionView(correction: $corrector)
                        VStack {
                            HStack {
                                Spacer()
                                Image("Delete")
                                    .onTapGesture {
                                        if let i = correction.correctors.firstIndex(where: {$0.isEqual(to: corrector)}) {
                                            correction.correctors.remove(at: i)
                                        }
                                    }
                                    .padding()
                            }
                            Spacer()
                        }
                    }
                    .padding()
                }
                HStack {
                    Button("Add Saturation Correction") {
                        correction.correctors.append(SaturationCorrection(gamma: 1))
                    }
                    Button("Add Channel Linear Correction") {
                        correction.correctors.append(ChannelLinearCorrection(strength: RGB(0.8, 0.4, 0.3)))
                    }
                }
            }, label: {
                HStack {
                    Text("Color Corrections")
                        .padding(.leading)
                        .font(.title)
                    Spacer()
                }
            })
        }
    }
}

struct ChainedCorrectionView_Previews: PreviewProvider {
    static var previews: some View {
        ColorCorrectionView(correction: .constant(ChainedColorCorrection(correctors: [SaturationCorrection(gamma: 1)])))
    }
}
