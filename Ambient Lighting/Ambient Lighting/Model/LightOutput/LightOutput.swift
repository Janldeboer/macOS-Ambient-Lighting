//
//  LightOutput.swift
//  Ambient Lighting
//
//  Created by Jan de Boer on 25.03.21.
//

import Foundation

protocol LightOutput: CustomStringConvertible {
    func outputColors(colors: [CGColor])
}
