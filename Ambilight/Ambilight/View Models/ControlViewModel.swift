//
//  ControlViewModel.swift
//  Ambilight
//
//  Created by Jan de Boer on 08.03.22.
//

import Foundation

class ControlViewModel: ObservableObject {
    
    @Published var isRunning = false
    
    @Published var fps: Double = 15
    
    @Published var measuredFPS: Double = 15
    
}
