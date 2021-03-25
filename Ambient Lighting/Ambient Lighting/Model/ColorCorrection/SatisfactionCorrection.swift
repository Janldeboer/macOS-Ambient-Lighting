//
//  SatisfactionCorrection.swift
//  Ambient Lighting
//
//  Created by Jan de Boer on 25.03.21.
//

import Foundation

struct SatisfactionCorrection: ColorCorrection {
    var gamma: CGFloat
    
    func correctColor(color: CGColor) -> CGColor {
        if let components = color.components {
            let red = components[0]
            let green = components[1]
            let blue = components[2]
            let rgb = RGB(red: red, green: green, blue: blue)
            var hsv = HSV(rgb: rgb)
            
            hsv.correctSaturation(gamma: gamma)
            
            return hsv.getCGColor()
            
        } else {
            return color
        }
    }
    
}

extension HSV {
    mutating func correctSaturation(gamma: CGFloat) {
        if (gamma <= 0.0) {
            return
        }
        sat = pow(sat, gamma);
    }
}
