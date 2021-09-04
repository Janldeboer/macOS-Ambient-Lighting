//
//  CorrectedLightOutput.swift
//  Ambient Lighting
//
//  Created by Jan de Boer on 26.03.21.
//

import Foundation

protocol CorrectedLightOutput: LightOutput {
    var correction: ColorCorrection? { get set }
    func outputCorrectedColors(colors: [CGColor])
}

extension CorrectedLightOutput {
    func outputColors(colors: [CGColor]) {
        if let correct = correction {
            outputCorrectedColors(colors: correct.correctColors(colors: colors))
        } else {
            outputCorrectedColors(colors: colors)
        }
    }
}
