//
//  MatrixSplitter.swift
//  Ambient Lighting
//
//  Created by Jan de Boer on 25.03.21.
//

import Foundation

struct MatrixSplitter: ImageSplitter {
    
    var config: MatrixSplitterConfiguration
    
    func splitImage(image: CGImage) -> [CGImage] {
        var images: [CGImage] = []
        
        let partWidth: Int = image.width / config.numberOfColumns
        let partHeight: Int = image.height / config.numberOfRows
        
        for coord in config.requiredParts {
            let rect = CGRect(x: coord.x * partWidth, y: coord.y * partHeight, width: partWidth, height: partHeight)
            if let cropped = image.cropping(to: rect) {
                images.append(cropped)
            }
        }
        return images
    }
}
