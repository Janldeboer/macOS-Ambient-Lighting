//
//  ImageSource.swift
//  Ambient Lighting
//
//  Created by Jan de Boer on 25.03.21.
//

import Foundation

protocol ImageSource: CustomStringConvertible, PipelineStarter {
    var listener: ImageListener?  { get set }
    func getImage() -> CGImage?
}

extension ImageSource {
    func startPipeline() {
        if let image = getImage() {
            listener?.handle(image: image)
        }
    }
}
