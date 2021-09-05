//
//  AmbientLightingViewModel.swift
//  Ambient Lighting
//
//  Created by Jan de Boer on 04.09.21.
//

import Foundation

class AmbientLightingModel: ObservableObject {
    @Published var source: ImageSource? = nil {
        didSet {
            keepIsRunningValid()
        }
    }
    @Published var splitter: ImageSplitter? = nil {
        didSet {
            keepIsRunningValid()
        }
    }
    @Published var reducer: ImageReduction? = ScalingReduction() {
        didSet {
            keepIsRunningValid()
        }
    }
    @Published var correction: ColorCorrection = ChainedColorCorrection(correctors: [SaturationCorrection(gamma: 1)])
    @Published var output: LightOutput? = nil {
        didSet {
            keepIsRunningValid()
        }
    }
    
    @Published var colors: [CGColor] = [] {
        didSet {
            if let out = output {
                out.outputColors(colors: colors)
            }
        }
    }
    
    var timer: Timer = Timer()
    
    var isRunning: Bool = false {
        didSet {
            if isRunning {
                timer = Timer.scheduledTimer(timeInterval: 0.04, target: self, selector: #selector(fire), userInfo: nil, repeats: true)
            } else {
                timer.invalidate()
            }
        }
    }
    
    init() {
        
    }
    
    init (source: ImageSource, splitter: ImageSplitter, reducer: ImageReduction, output: LightOutput) {
        self.source = source
        self.splitter = splitter
        self.reducer = reducer
        self.output = output
    }
    
    func refreshColors() {
        if source != nil && splitter != nil && reducer != nil && output != nil {
            let image = source!.getImage()
            let parts = splitter!.splitImage(image: image)
            let uncorrected = reducer!.reduceImages(images: parts)
            colors = correction.correctColors(colors: uncorrected)
        }
    }
    
    func keepIsRunningValid() {
        if source == nil || splitter == nil || reducer == nil || output == nil {
            isRunning = false
        }
    }
    
    @objc func fire()
    {
        refreshColors()
    }
}
