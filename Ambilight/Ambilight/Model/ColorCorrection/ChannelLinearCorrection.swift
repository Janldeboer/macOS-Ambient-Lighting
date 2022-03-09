//
//  ChannelLinearCorrection.swift
//  Ambient Lighting
//
//  Created by Jan de Boer on 25.03.21.
//

import Foundation

struct ChannelLinearCorrection: ChannelColorCorrection, ColorCorrection, Equatable {
    var id = UUID()
    var strength: RGB
    
    func correctColor(color: CGColor) -> CGColor {
        if let components = color.components {
            let r = components[0] * strength.red
            let g = components[1] * strength.green
            let b = components[2] * strength.blue
            return CGColor(red: r, green: g, blue: b, alpha: 1)
        } else {
            return color
        }
    }
    
    static func == (lhs: ChannelLinearCorrection, rhs: ChannelLinearCorrection) -> Bool {
        return lhs.id == rhs.id
    }
}
