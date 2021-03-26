//
//  MatrixSplitter.swift
//  Ambient Lighting
//
//  Created by Jan de Boer on 25.03.21.
//

import Foundation

struct MatrixSplitter: ImageSplitter {
    
    var config: MatrixSplitterConfiguration
    
    var widthCrop: CGFloat = 0
    var heightCrop: CGFloat = 0
    
    func splitImage(image: CGImage) -> [CGImage] {
        var images: [CGImage] = []
        
        let partWidth: Int = image.width / config.numberOfColumns
        let partHeight: Int = image.height / config.numberOfRows
        
        let maxX = Int((1 - widthCrop) * CGFloat(image.width)) - partWidth
        let minX = Int(widthCrop * CGFloat(image.width))
        
        let maxY = Int((1 - heightCrop) * CGFloat(image.height)) - partHeight
        let minY = Int(heightCrop * CGFloat(image.height))
        
        for coord in config.requiredParts {
            var x = coord.x * partWidth
            var y = coord.y * partHeight
            
            if x < minX {
                x = minX
            } else if x > maxX {
                x = maxX
            }
            
            if y < minY {
                y = minY
            } else if x > maxY {
                y = maxY
            }
            
            let rect = CGRect(x: x, y: y, width: partWidth, height: partHeight)
            if let cropped = image.cropping(to: rect) {
                images.append(cropped)
            }
        }
        return images
    }
}
