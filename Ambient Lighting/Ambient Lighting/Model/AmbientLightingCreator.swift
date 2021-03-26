//
//  AmbientLightingCreator.swift
//  Ambient Lighting
//
//  Created by Jan de Boer on 25.03.21.
//

import Foundation

struct AmbientLightingCreator {
    
    var imageSplitter: ImageSplitter
    var imageReduction: ImageReduction
    var colorCorrection: ColorCorrection?
    
    func getUncorrectedColors(forImage image: CGImage) -> [CGColor] {
        let images = imageSplitter.splitImage(image: image)
        return imageReduction.reduceImages(images: images)
    }
    
    func getColors(forImage image: CGImage) -> [CGColor] {
        var colors = getUncorrectedColors(forImage: image)
        if let correction = colorCorrection {
            colors = correction.correctColors(colors: colors)
        }
        return colors
    }
    
}
