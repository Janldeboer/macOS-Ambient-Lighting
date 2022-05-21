//
//  SourceViewModel.swift
//  Ambilight
//
//  Created by Jan de Boer on 08.03.22.
//

import Foundation

class SourceViewModel: ObservableObject {
    
    @Published var images: [CGDirectDisplayID : CGImage] = [:]
    @Published var imageSource: ScreenCapture
    
    init(screenCapture: ScreenCapture) {
        self.imageSource = screenCapture
    }
    
    func refreshImages() {
        images = [:]
        for id in imageSource.getActiveDisplays() {
            images[id] = imageSource.getImage(id: id)
        }
    }
}
