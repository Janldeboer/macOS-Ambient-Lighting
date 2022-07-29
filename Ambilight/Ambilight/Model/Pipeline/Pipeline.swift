//
//  Pipeline.swift
//  Ambilight
//
//  Created by Jan de Boer on 29.07.22.
//

import Foundation

/*
 This class keeps track of all the different parts of the pipeline,
 without interacting with the data flow itself.
 
 Tasks:
 - Keep track of all parts of the pipeline
 - Make pipeline parts accessable via GUI
 - Start / Stop Pipeline
    - Zeitgeber to be implemented seperatly
 
 */

class Pipeline {
    
    var zeitgeber: Zeitgeber
    var source: ScreenCapture
    var splitter: GridSplitter
    var reducer: ScalingReduction
    var corrector: ColorCorrection
    var output: SerialLightOutput
    
    init() {
        output = SerialLightOutput()
        corrector = ChainedColorCorrection()
        corrector.listener = output
        reducer = ScalingReduction()
        reducer.listener = corrector
        splitter = GridSplitter()
        splitter.listener = reducer
        source = ScreenCapture()
        source.listener = splitter
        zeitgeber = Zeitgeber()
        zeitgeber.starter = source
    }
    
}
