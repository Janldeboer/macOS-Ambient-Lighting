//
//  MatrixSplitter.swift
//  Ambient Lighting
//
//  Created by Jan de Boer on 25.03.21.
//

import Foundation
import SwiftUI

struct GridSplitter: ImageSplitter {
    
    var description: String = "Grid Splitter"
    
    var config = GridConfiguration()
    
    var widthCrop: CGFloat = 0
    var heightCrop: CGFloat = 0
    
    let blackBarDetector = BlackBarDetector()
    
    func splitImage(image: CGImage) -> [CGImage] {
        var images: [CGImage] = []
        
        let partWidth: Int = image.width / config.columns
        let partHeight: Int = image.height / config.rows
        
        let cutoffs = config.ignoreBlackBars ? blackBarDetector.getCroping(image: image) : nil
        
        for coord in config.parts {
            let rect = getRect(fromCoord: coord, width: partWidth, height: partHeight, cutoffs: cutoffs)
            if let cropped = image.cropping(to: rect) {
                images.append(cropped)
            }
        }
        return images
    }
    
    func getRect(fromCoord coord: Coord, width: Int, height: Int, cutoffs: Cutoffs?) -> CGRect {
        
        var x = coord.x * width
        var y = coord.y * height
        
        if let c = cutoffs {
            x = x.clamped(to: c.xMin ... c.xMax)
            y = y.clamped(to: c.yMin ... c.yMax)
        }
        
        return CGRect(x: x, y: y, width: width, height: height)
    }
    
    func getColor(x: Int, y: Int, colors: [CGColor]) -> Color {
        let coord = Coord(x: x, y: y)
        if let i = config.parts.firstIndex(of: coord) {
            if i < colors.count {
                return Color(colors[i])
            }
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
