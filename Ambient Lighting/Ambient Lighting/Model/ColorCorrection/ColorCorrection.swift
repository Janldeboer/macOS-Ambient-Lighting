//
//  ColorCorrection.swift
//  Ambient Lighting
//
//  Created by Jan de Boer on 25.03.21.
//

import Foundation

protocol ColorCorrection {
    func correctColor(color: CGColor) -> CGColor
    func correctColors(colors: [CGColor]) -> [CGColor]
}

extension ColorCorrection {
    func correctColors(colors: [CGColor]) -> [CGColor] {
        var newColors: [CGColor] = []
        for color in colors {
            newColors.append(correctColor(color: color))
        }
        return newColors
    }
}

extension CGColor {
    func correctColor(usingCorrector corrector: ColorCorrection) -> CGColor {
        return corrector.correctColor(color: self)
    }
}

protocol ChannelColorCorrection : ColorCorrection {
    var strength: RGB { get set }
}
