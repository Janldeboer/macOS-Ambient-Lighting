//
//  MatrixSplitter.swift
//  Ambient Lighting
//
//  Created by Jan de Boer on 25.03.21.
//

import Foundation
import SwiftUI

class GridSplitter: ObservableObject, ImageListener {
    
    var description: String = "Grid Splitter"
    
    var listener: SplitListener?

    
    @Published var lastSplit: [CGImage] = []
    
    @Published var config = GridConfiguration()
    
    var widthCrop: CGFloat = 0
    var heightCrop: CGFloat = 0
    
    var blackBarDetector = BlackBarDetector()
    
    func handle(image: CGImage) {
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
        lastSplit = images
        listener?.handle(splits: images)
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
    
}

extension Comparable {
    func clamped(to limits: ClosedRange<Self>) -> Self {
        return min(max(self, limits.lowerBound), limits.upperBound)
    }
}
