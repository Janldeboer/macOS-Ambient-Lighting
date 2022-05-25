//
//  AmbilightManager.swift
//  Ambilight
//
//  Created by Jan de Boer on 08.03.22.
//

import Foundation
import SwiftUI

class AmbilightManager: ObservableObject {
    
    @Published var interval: Double = 0.04  {
        didSet {
            if isRunning {
                timer?.invalidate()
                timer = Timer.scheduledTimer(withTimeInterval: interval, repeats: true, block: timerFired(_:))
            } else {
                timer?.invalidate()
                timer = nil
            }
        }
    }
    
    var timer: Timer?
    
    var isCalculating = false
    
    var source: ScreenCapture? = ScreenCapture()
    @Published var splitter: GridSplitter = GridSplitter()
    var reducer: ImageReduction? = ScalingReduction()
    var corrector: ChainedColorCorrection = Examples.getChainedCorrection()
    var output: LightOutput? = SerialLightOutput()
    
    var t0 = Date()
    
    var image: CGImage?
    @Published var splits: [CGImage] = []
    @Published var colors: [CGColor] = []
    @Published var correctedColors: [CGColor] = []
    
    var lastFinish: Date = Date()
    var measurements: [Double] = []
    @Published var measuredFPS: Int = 0
    
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
        Task {
            let result = await updateAsync()
            colors = result.2
            measuredFPS = result.4
        }
    }
    
    func updateAsync() async -> (CGImage?, [CGImage], [CGColor], [CGColor], Int) {
        guard  let source = source, let reducer = reducer, let output = output else {
            return (nil,[],[],[], 0)
        }
        
        t0 = Date()
        let img = source.getImage()
        print("Get: \(t0.distance(to: Date()).millisecond)")
        t0 = Date()
        let calcSplits = splitter.splitImage(image: img)
        print("Split: \(t0.distance(to: Date()).millisecond)")
        t0 = Date()
        let calcColors = reducer.reduceImages(images: calcSplits)
        print("Smooth: \(t0.distance(to: Date()).millisecond)")
        t0 = Date()
        let calcCorrectedColors = corrector.correctColors(colors: calcColors)
        print("Correct: \(t0.distance(to: Date()).millisecond)")
        t0 = Date()
        output.outputColors(colors: calcCorrectedColors)
        print("Output: \(t0.distance(to: Date()).millisecond)")
        measurements.append(Double(lastFinish.distance(to: Date()).millisecond))
        let avg = measurements.average()
        while measurements.count >= 10 {
            measurements.removeFirst()
        }
        let fps = avg == 0 ? 0 : Int(1000 / avg)
        lastFinish = Date()
        return (img, calcSplits, calcColors, correctedColors, fps)
    }
    
    func fetchImage() async -> CGImage? {
        if let source = source {
            return source.getImage()
        } else {
            return nil
        }
    }
    
}

extension TimeInterval {
    var millisecond: Int {
        Int((self*1000).truncatingRemainder(dividingBy: 1000))
    }
}

extension Sequence where Element: AdditiveArithmetic {
    /// Returns the total sum of all elements in the sequence
    func sum() -> Element { reduce(.zero, +) }
}

extension Collection where Element: BinaryFloatingPoint {
    /// Returns the average of all elements in the array
    func average() -> Element { isEmpty ? .zero : sum() / Element(count) }
}
