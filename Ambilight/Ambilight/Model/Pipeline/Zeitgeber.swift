//
//  Zeitgeber.swift
//  Ambilight
//
//  Created by Jan de Boer on 29.07.22.
//

import Foundation

class Zeitgeber: ObservableObject {
    
    var timer: Timer?
    var starter: PipelineStarter? = nil
    
    
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
