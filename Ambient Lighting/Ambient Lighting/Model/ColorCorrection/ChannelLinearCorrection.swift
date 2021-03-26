//
//  ChannelLinearCorrection.swift
//  Ambient Lighting
//
//  Created by Jan de Boer on 25.03.21.
//

import Foundation

struct ChannelLinearCorrection: ColorCorrection {
    
    var maxColor: RGB
    
    func correctColor(color: CGColor) -> CGColor {
        if let components = color.components {
            let r = components[0] * maxColor.red
            let g = components[1] * maxColor.green
            let b = components[2] * maxColor.blue
            return CGColor(red: r, green: g, blue: b, alpha: 1)
        } else {
            return color
        }
    }
}
