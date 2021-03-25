//
//  ImageSplitter.swift
//  Ambient Lighting
//
//  Created by Jan de Boer on 25.03.21.
//

import Foundation

protocol ImageSplitter {
    func splitImage(image: CGImage) -> [CGImage]
}

extension CGImage {
    func splitImage(usingSplitter splitter: ImageSplitter) -> [CGImage] {
        return splitter.splitImage(image: self)
    }
}
