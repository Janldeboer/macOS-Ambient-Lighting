//
//  MultiLightOutput.swift
//  Ambient Lighting
//
//  Created by Jan de Boer on 25.03.21.
//

import Foundation

struct MultiLightOutput: LightOutput {
    
    var outputs: [LightOutput]
    
    func outputColors(colors: [CGColor]) {
        for output in outputs {
            output.outputColors(colors: colors)
        }
    }
}
