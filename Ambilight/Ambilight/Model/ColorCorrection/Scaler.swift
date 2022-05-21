//
//  Scaler.swift
//  Ambilight
//
//  Created by Jan de Boer on 09.03.22.
//

import Foundation

protocol Scaler {
    func scale(_ num: CGFloat, scale: CGFloat) -> CGFloat
    var name: String { get }
}

struct LinearScaler: Scaler {
    
    let name: String = "Linear Scaler"
    
    func scale(_ num: CGFloat, scale: CGFloat) -> CGFloat {
        return num * scale
    }
}

struct GammaScaler: Scaler {
    
    let name: String = "Gamma Scaler"
    
    func scale(_ num: CGFloat, scale: CGFloat) -> CGFloat {
        return pow(num, scale)
    }
}
