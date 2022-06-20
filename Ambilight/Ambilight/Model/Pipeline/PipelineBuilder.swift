//
//  PipelineBuilder.swift
//  Ambilight
//
//  Created by Jan de Boer on 20.06.22.
//

import Foundation

class PipelineBuilder {
    func buildPipeline(corrector: ColorCorrection? = nil) -> PipelineStarter {
        var output = SerialLightOutput()
        var reducer = ScalingReduction()
        if var corrector = corrector {
            corrector.listener = output
            reducer.listener = corrector
        } else {
            reducer.listener = output
        }
        var splitter = GridSplitter()
        splitter.listener = reducer
        var starter = ScreenCapture()
        starter.listener = splitter
        return starter
        
    }
}
