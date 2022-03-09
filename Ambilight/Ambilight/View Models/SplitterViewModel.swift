//
//  SplitterViewModel.swift
//  Ambilight
//
//  Created by Jan de Boer on 09.03.22.
//

import Foundation
import SwiftUI

class SplitterViewModel: ObservableObject {
    @Published var config = GridConfiguration() {
        didSet {
            splitter.config = config
        }
    }
    
    @Published var splitter = GridSplitter()
    
    func getImage(x: Int, y: Int, images: [CGImage]) -> Image {
        let coord = Coord(x: x, y: y)
        if let i = config.parts.firstIndex(of: coord) {
            if i < images.count {
                return Image(nsImage: NSImage(cgImage: images[i], size: CGSize(width: 10, height: 10)))
            }
            return Image(systemName: "square")
        } else {
            return Image(systemName: "square")
        }
    }
    
    
    func getColor(x: Int, y: Int, colors: [CGColor]) -> Color {
        let coord = Coord(x: x, y: y)
        if let i = config.parts.firstIndex(of: coord) {
            if i < colors.count {
                return Color(colors[i])
            }
            return .blue
        } else {
            return .gray
        }
    }
    
    func getText(x: Int, y: Int) -> String {
        let coord = Coord(x: x, y: y)
        if let i = config.parts.firstIndex(of: coord) {
            return String(i)
        }
        return ""
    }
}
