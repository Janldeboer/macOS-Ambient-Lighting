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
    
    static func getChannelLinearCorrection() -> ChannelLinearCorrection {
        return ChannelLinearCorrection(strength: RGB(1.0, 0.6, 0.2))
    }
    
    static func getChannelGammaCorrection() -> ChannelGammaCorrection {
        return ChannelGammaCorrection(strength: RGB(1.5, 1.5, 1.5))
    }
    
    static func getChainedCorrection() -> ChainedColorCorrection {
        return ChainedColorCorrection(correctors: [getSatCorrection(), getChannelLinearCorrection()])
    }
}
