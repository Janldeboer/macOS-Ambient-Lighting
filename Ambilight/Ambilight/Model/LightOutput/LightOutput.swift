//
//  LightOutput.swift
//  Ambient Lighting
//
//  Created by Jan de Boer on 25.03.21.
//

import Foundation

protocol LightOutput: CustomStringConvertible, ColorListener {
    func outputColors(colors: [CGColor])
}

protocol ColorListener {
    func handleColors(_ colors: [CGColor])
}

extension LightOutput {
    func handleColors(_ colors: [CGColor]) {
        outputColors(colors: colors)
    }
}
