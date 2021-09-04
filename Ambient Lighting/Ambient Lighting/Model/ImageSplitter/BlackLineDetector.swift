//
//  BlackLineDetector.swift
//  Ambient Lighting
//
//  Created by Jan de Boer on 08.08.21.
//

import SwiftUI
import Foundation

struct BlackLineDetector {
    
    let accuracy: CGFloat = 0.05
    
    let minFactor = 0.2
    let maxFactor = 0.8
    
    /// TODO : Refactor this ugly method
    func getCroping(image: CGImage) -> (minX: Int, maxX: Int, minY: Int, maxY: Int) {
        let width = image.width
        let height = image.height
        
        guard let pixels = image.pixelData() else {
            return (minX: 0, maxX: width, minY: 0, maxY: height)
        }
        
        let xStep = Int(CGFloat(image.width) * accuracy)
        let yStep = Int(CGFloat(image.height) * accuracy)
        var flag = true
        
        var xTest: Int = 0
        var yTest: Int = 0
        
        while (flag) {
            let index = 4 * (xTest + width * yTest)
            let sum = getSum(pixels[index], pixels[index + 1], pixels[index + 2])
            if sum > 30 {
                flag = true
                break
            }
            xTest = xTest + xStep
            if xTest >= image.width {
                xTest = 0
                yTest = yTest + yStep
                if yTest >= Int(Double(image.height) * minFactor) {
                    flag = true
                    break
                }
            }
        }
        
        let minY = yTest
        
        xTest = 0
        yTest = image.height - 1
        
        while (flag) {
            let index = 4 * (xTest + width * yTest)
            let sum = getSum(pixels[index], pixels[index + 1], pixels[index + 2])
            if sum > 30 {
                flag = true
                break
            }
            xTest = xTest + xStep
            if xTest >= image.width {
                xTest = 0
                yTest = yTest - yStep
                if yTest <= Int(Double(image.height) * maxFactor) {
                    flag = true
                    break
                }
            }
        }
        
        let maxY = yTest
        
        xTest = 0
        yTest = 0
        
        while (flag) {
            let index = 4 * (xTest + width * yTest)
            let sum = getSum(pixels[index], pixels[index + 1], pixels[index + 2])
            if sum > 30 {
                flag = true
                break
            }
            yTest = yTest + yStep
            if yTest >= image.height {
                yTest = 0
                xTest = xTest + xStep
                if xTest >= Int(Double(image.width) * minFactor) {
                    flag = true
                    break
                }
            }
        }
        
        let minX = xTest
        
        xTest = image.width - 1
        yTest = 0
        
        while (flag) {
            let index = 4 * (xTest + width * yTest)
            let sum = getSum(pixels[index], pixels[index + 1], pixels[index + 2])
            if sum > 30 {
                flag = true
                break
            }
            yTest = yTest + yStep
            if yTest >= image.height {
                yTest = 0
                xTest = xTest - xStep
                if xTest <= Int(Double(image.width) * maxFactor) {
                    flag = true
                    break
                }
            }
        }
        
        let maxX = xTest
        
        
        return (minX: minX, maxX: maxX, minY: minY, maxY: maxY)
    }
    
    func getSum(_ r: UInt8, _ g: UInt8, _ b: UInt8) -> Int {
        return Int(r) + Int(g) + Int(b)
    }
}
