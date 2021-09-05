//
//  BlackBarDetector.swift
//  Ambient Lighting
//
//  Created by Jan de Boer on 08.08.21.
//

import SwiftUI
import Foundation

struct BlackBarDetector {
    
    let accuracy: CGFloat = 0.05
    
    let minFactor = 0.2
    let maxFactor = 0.8
    
    func getCroping(image: CGImage) -> Cutoffs {
        let width = image.width
        let height = image.height
        
        guard let pixels = image.pixelData() else {
            return Cutoffs(xMin: 0, xMax: width, yMin: 0, yMax: height)
        }
        
        var cutoffs = Cutoffs(xMin: 0, xMax: 0, yMin: 0, yMax: 0)
        let xStepSize = CGFloat(image.width) * accuracy
        let yStepSize = CGFloat(image.height) * accuracy
        let numberOfSteps = Int(0.4/accuracy) * Int(1/accuracy)
        let tolerance = Int(1/accuracy)
        
        for direction in [Direction.UP, .DOWN, .LEFT, .RIGHT] {
            var xTest: Int = direction == .LEFT ? width - 1 : 0
            var yTest: Int = direction == .UP ? height - 1 : 0
            let xStep = direction.isHorizontal() ? direction.directionFactor() : 0
            let yStep = direction.isHorizontal() ? 0 : direction.directionFactor()
            var toleranceCount = 0
            for _ in 0 ..< numberOfSteps {
                let index = 4 * (xTest + width * yTest)
                let sum = getSum(pixels[index], pixels[index + 1], pixels[index + 2])
                if sum > 50 {
                    toleranceCount = toleranceCount + (sum / 50)
                    if toleranceCount > tolerance {
                        break
                    }
                }
                if direction.isHorizontal() {
                    yTest = yTest + 1 * Int(yStepSize)
                    if yTest >= image.height {
                        yTest = 0
                        xTest = xTest + xStep * Int(xStepSize)
                        toleranceCount = 0
                    }
                } else {
                    xTest = xTest + 1 * Int(xStepSize)
                    if xTest >= image.width {
                        xTest = 0
                        yTest = yTest + yStep * Int(yStepSize)
                        toleranceCount = 0
                    }
                }
            }
            cutoffs.setDirection(direction, x: xTest, y: yTest)
        }
        
        return cutoffs
    }
    
    func getSum(_ r: UInt8, _ g: UInt8, _ b: UInt8) -> Int {
        return Int(r) + Int(g) + Int(b)
    }
}

enum Direction {
    case UP, RIGHT, DOWN, LEFT
    
    func isHorizontal() -> Bool {
        switch self {
        case .LEFT, .RIGHT:
            return true
        case .UP, .DOWN:
            return false
        }
    }
    
    func directionFactor() -> Int {
        switch self {
        case .DOWN, .RIGHT:
            return 1
        case .UP, .LEFT:
            return -1
        }
    }
}

struct Cutoffs {
    var xMin: Int
    var xMax: Int
    var yMin: Int
    var yMax: Int
    
    mutating func setDirection(_ direction: Direction, x: Int, y: Int) {
        switch direction {
        case .UP:
            yMax = y
        case .RIGHT:
            xMin = x
        case .DOWN:
            yMin = y
        case .LEFT:
            xMax = x
        }
    }
}
