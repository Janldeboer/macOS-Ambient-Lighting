//
//  AmbilightCreator.swift
//  Ambient Lighting
//
//  Created by Jan de Boer on 25.03.21.
//

import Foundation

struct AmbilightCreator {
    
    var imageSplitter: ImageSplitter
    var imageReduction: ImageReduction
    var colorCorrection: ColorCorrection?
    
    func getColors(forImage image: CGImage) -> [CGColor] {
        let images = imageSplitter.splitImage(image: image)
        var colors = imageReduction.reduceImages(images: images)
        if let correction = colorCorrection {
            colors = correction.correctColors(colors: colors)
        }
        return colors
    }
    
}
