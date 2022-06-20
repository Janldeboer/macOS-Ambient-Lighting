//
//  ChannelColorCorrection.swift
//  Ambilight
//
//  Created by Jan de Boer on 09.03.22.
//

import Foundation

class ChannelColorCorrection: ColorCorrection {
    var listener: ColorListener? = nil
    
    var id: UUID = UUID()
    var scaler: Scaler = LinearScaler()
    var strength: RGB = RGB(1, 1, 1)
    
    init() {}
    
    init(scaler: Scaler, strength: RGB) {
        self.scaler = scaler
        self.strength = strength
    }
    
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
