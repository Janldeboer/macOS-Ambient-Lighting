//
//  ChannelColorCorrection.swift
//  Ambilight
//
//  Created by Jan de Boer on 09.03.22.
//

import Foundation

struct ChannelColorCorrection : ColorCorrection {
    var id: UUID = UUID()
    var scaler: Scaler
    var strength: RGB
    
    func correctColor(color: CGColor) -> CGColor {
        if let components = color.components {
            let r = scaler.scale(components[0], scale: strength.red)
            let g = scaler.scale(components[1], scale: strength.green)
            let b = scaler.scale(components[2], scale: strength.blue)
            return CGColor(red: r, green: g, blue: b, alpha: 1)
        } else {
            return color
        }
    }
}
