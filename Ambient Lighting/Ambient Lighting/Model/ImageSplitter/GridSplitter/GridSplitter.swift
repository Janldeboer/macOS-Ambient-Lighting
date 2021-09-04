//
//  MatrixSplitter.swift
//  Ambient Lighting
//
//  Created by Jan de Boer on 25.03.21.
//

import Foundation
import SwiftUI

struct GridSplitter: ImageSplitter {
    
    var config = GridConfiguration()
    
    var widthCrop: CGFloat = 0
    var heightCrop: CGFloat = 0
    
    let blackLineDetector = BlackLineDetector()
    var ignoreBlackLines = true
    
    func splitImage(image: CGImage) -> [CGImage] {
        var images: [CGImage] = []
        
        let partWidth: Int = image.width / config.columns
        let partHeight: Int = image.height / config.rows
        
        let cutoffs = blackLineDetector.getCroping(image: image)
        
        for coord in config.parts {
            var x = coord.x * partWidth
            var y = coord.y * partHeight
            
            if ignoreBlackLines {
                x = x.clamped(to: cutoffs.minX ... cutoffs.maxX)
                y = y.clamped(to: cutoffs.minY ... cutoffs.maxY)
            }
            
            let rect = CGRect(x: x, y: y, width: partWidth, height: partHeight)
            if let cropped = image.cropping(to: rect) {
                images.append(cropped)
            }
        }
        return images
    }
    
    func getColor(x: Int, y: Int) -> Color {
        let coord = Coord(x: x, y: y)
        if config.parts.contains(coord) {
            return .blue
        } else {
            return .gray
        }
    }
    
    func getText(x: Int, y: Int) -> String {
        let coord = Coord(x: x, y: y)
        if let i = config.parts.firstIndex(of: coord) {
            return String(i)
        }
        return ""
    }
}

extension Comparable {
    func clamped(to limits: ClosedRange<Self>) -> Self {
        return min(max(self, limits.lowerBound), limits.upperBound)
    }
}

extension AmbientLightingModel {
    func getColor(x: Int, y: Int) -> Color {
        if let s = splitter as? GridSplitter {
            let coord = Coord(x: x, y: y)
            if s.config.parts.contains(coord) {
                return .blue
            } else {
                return .gray
            }
        } else {
            return .black
        }
    }
}
