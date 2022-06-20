//
//  ChainedColorCorrection.swift
//  Ambient Lighting
//
//  Created by Jan de Boer on 25.03.21.
//

import Foundation

class ChainedColorCorrection: ColorCorrection, Equatable {
    var listener: ColorListener? = nil
    var id = UUID()
    var correctors: [ColorCorrection] = []
    
    init() {}
    
    init(listener: ColorListener?, correctors: [ColorCorrection]) {
        self.listener = listener
        self.correctors = correctors
    }
    
    
    func correctColor(color: CGColor) -> CGColor {
        var newColor = color
        for corrector in correctors {
            newColor = corrector.correctColor(color: newColor)
        }
        return newColor
    }
    
    static func == (lhs: ChainedColorCorrection, rhs: ChainedColorCorrection) -> Bool {
        return lhs.id == rhs.id
    }
}
