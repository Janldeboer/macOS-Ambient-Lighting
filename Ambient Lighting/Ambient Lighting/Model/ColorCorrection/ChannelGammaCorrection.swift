//
//  ChannelGammaCorrection.swift
//  Ambient Lighting
//
//  Created by Jan de Boer on 26.03.21.
//

import Foundation

struct ChannelGammaCorrection: ChannelColorCorrection {
    
    var strength: RGB
    
    func correctColor(color: CGColor) -> CGColor {
        if let components = color.components {
            let r = pow(components[0], strength.red)
            let g = pow(components[1], strength.green)
            let b = pow(components[2], strength.blue)
            return CGColor(red: r, green: g, blue: b, alpha: 1)
        } else {
            return color
        }
    }
}
