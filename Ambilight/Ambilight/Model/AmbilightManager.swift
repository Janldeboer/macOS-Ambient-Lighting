//
//  AmbilightManager.swift
//  Ambilight
//
//  Created by Jan de Boer on 08.03.22.
//

import Foundation
import SwiftUI

class AmbilightManager: ObservableObject {
    
    final let interval = 0.1
    
    var timer: Timer?
    
    var source: ImageSource? = ScreenCapture()
    var splitter: ImageSplitter? = GridSplitter()
    var reducer: ImageReduction? = ScalingReduction()
    var corrector: ColorCorrection? = Examples.getChainedCorrection()
    var output: LightOutput? = SerialLightOutput()
    
    @Published var image: CGImage?
    @Published var splits: [CGImage] = []
    @Published var colors: [CGColor] = []
    
    @Published var isRunning: Bool = false {
        didSet {
            if isRunning {
                timer = Timer.scheduledTimer(withTimeInterval: interval, repeats: true, block: timerFired(_:))
            } else {
                timer?.invalidate()
                timer = nil
            }
        }
    }
    
    func getScreenCapture() -> ScreenCapture {
        if let sc = source! as? ScreenCapture {
            return sc
        } else {
            return ScreenCapture()
        }
    }
    
    func timerFired(_ timer: Any) {
        if let source = source {
            image = source.getImage()
        }
        if let image = image, let splitter = splitter {
            splits = splitter.splitImage(image: image)
        }
        if let reducer = reducer {
            colors = reducer.reduceImages(images: splits)
        }
        if let corrector = corrector {
            colors = corrector.correctColors(colors: colors)
            print(colors.first ?? "No colors :(")
        }
        if let output = output {
            output.outputColors(colors: colors)
        }
    }
    
}
