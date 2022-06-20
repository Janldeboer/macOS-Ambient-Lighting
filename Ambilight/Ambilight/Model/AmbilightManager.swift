//
//  AmbilightManager.swift
//  Ambilight
//
//  Created by Jan de Boer on 08.03.22.
//

import Foundation
import SwiftUI

class AmbilightManager: ObservableObject {
    
    @Environment(\.managedObjectContext) private var viewContext
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Item.timestamp, ascending: true)],
        animation: .default) private var configs: FetchedResults<Grid>
    
    @Published var interval: Double = 0.1  {
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
    var starter: PipelineStarter? = nil
    
    
    var t0 = Date()
    
    
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
    
    
    func timerFired(_ timer: Any) {
        Task {
            await updateAsync()
        }
    }
    
    func updateAsync() async {
        starter?.startPipeline()
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
