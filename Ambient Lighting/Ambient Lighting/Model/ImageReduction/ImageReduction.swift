//
//  ImageReduction.swift
//  Ambient Lighting
//
//  Created by Jan de Boer on 25.03.21.
//

import Foundation

protocol ImageReduction {
    func reduceImage(image: CGImage) -> CGColor
    func reduceImages(images: [CGImage]) -> [CGColor]
}

extension ImageReduction {
    func reduceImages(images: [CGImage]) -> [CGColor] {
        var colors: [CGColor] = []
        for image in images {
            colors.append(reduceImage(image: image))
        }
        return colors
    }
}

extension CGImage {
    func reduceImage(usingReducer reducer: ImageReduction) -> CGColor {
        return reducer.reduceImage(image: self)
    }
}
