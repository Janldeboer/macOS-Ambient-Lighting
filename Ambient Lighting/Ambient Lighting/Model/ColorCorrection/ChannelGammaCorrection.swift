//
//  ChannelGammaCorrection.swift
//  Ambient Lighting
//
//  Created by Jan de Boer on 26.03.21.
//

import Foundation

struct ChannelGammaCorrection: ColorCorrection {
    
    var rGamma: CGFloat
    var gGamma: CGFloat
    var bGamma: CGFloat
    
    func correctColor(color: CGColor) -> CGColor {
        if let components = color.components {
            let r = pow(components[0], rGamma)
            let g = pow(components[1], gGamma)
            let b = pow(components[2], bGamma)
            return CGColor(red: r, green: g, blue: b, alpha: 1)
        } else {
            return color
        }
    }
}
