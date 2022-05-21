//
//  SplitterViewModel.swift
//  Ambilight
//
//  Created by Jan de Boer on 09.03.22.
//

import Foundation
import SwiftUI

class SplitterViewModel: ObservableObject {
    @Published var splitter: GridSplitter
    
    init(splitter: GridSplitter) {
        self.splitter = splitter
    }
    
    func getImage(x: Int, y: Int, images: [CGImage]) -> Image {
        let coord = Coord(x: x, y: y)
        if let i = splitter.config.parts.firstIndex(of: coord) {
            if i < images.count {
                return Image(nsImage: NSImage(cgImage: images[i], size: CGSize(width: 10, height: 10)))
            }
            return Image(systemName: "square")
        } else {
            return Image(systemName: "square")
        }
    }
}
