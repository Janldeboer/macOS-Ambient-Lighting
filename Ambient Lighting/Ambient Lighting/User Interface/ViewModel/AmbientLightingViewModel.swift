//
//  AmbientLightingViewModel.swift
//  Ambient Lighting
//
//  Created by Jan de Boer on 04.09.21.
//

import Foundation

class AmbientLightingModel: ObservableObject {
    @Published var source: ImageSource? = nil
    @Published var splitter: ImageSplitter? = nil
    @Published var reducer: ImageReduction? = ScalingReduction()
    @Published var output: LightOutput? = nil
    
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
            colors = reducer!.reduceImages(images: parts)
        }
    }
    
    @objc func fire()
    {
        refreshColors()
    }
}
