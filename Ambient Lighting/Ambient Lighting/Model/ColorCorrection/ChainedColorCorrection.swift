//
//  ChainedColorCorrection.swift
//  Ambient Lighting
//
//  Created by Jan de Boer on 25.03.21.
//

import Foundation

struct ChainedColorCorrection: ColorCorrection {
    
    var correctors: [ColorCorrection]
    
    func correctColor(color: CGColor) -> CGColor {
        var newColor = color
        for corrector in correctors {
            newColor = corrector.correctColor(color: newColor)
        }
        return newColor
    }
}
