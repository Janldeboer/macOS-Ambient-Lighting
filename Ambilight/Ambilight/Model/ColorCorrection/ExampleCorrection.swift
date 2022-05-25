//
//  ExampleCorrection.swift
//  Ambient Lighting
//
//  Created by Jan de Boer on 26.03.21.
//

import Foundation

extension Examples {
    static func getSatCorrection() -> SaturationCorrection {
        return SaturationCorrection(gamma: 0.3)
    }
    
    static func getChannelLinearCorrection() -> ChannelColorCorrection {
        return ChannelColorCorrection(scaler: LinearScaler(), strength: RGB(1.0, 0.75, 0.5))
    }
    
    static func getChannelGammaCorrection() -> ChannelColorCorrection {
        return ChannelColorCorrection(scaler: GammaScaler(), strength: RGB(1.5, 1.5, 1.5))
    }
    
    static func getChainedCorrection() -> ChainedColorCorrection {
        return ChainedColorCorrection(correctors: [getSatCorrection(), getChannelLinearCorrection()])
    }
}
