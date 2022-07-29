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
    
    func rowBinding() -> Binding<Int> {
        return Binding(get: {
            return self.splitter.config.rows
        }, set: {
            self.splitter.config.rows = $0
        })
    }
    
    func columnBinding() -> Binding<Int> {
        return Binding(get: {
            return self.splitter.config.columns
        }, set: {
            self.splitter.config.columns = $0
        })
    }
    
    func numberOfPartsBinding() -> Binding<Int> {
        return Binding(get: {
            return self.splitter.config.numberOfParts
        }, set: {
            print("Setting number of parts to \($0)")
            self.splitter.config.numberOfParts = $0
        })
    }
    
    func startOffsetBinding() -> Binding<Int> {
        return Binding(get: {
            return self.splitter.config.startOffset
        }, set: {
            self.splitter.config.startOffset = $0
        })
    }
    
    func blackBarBinding() -> Binding<Bool> {
        return Binding(get: {
            return self.splitter.config.ignoreBlackBars
        }, set: {
            self.splitter.config.ignoreBlackBars = $0
        })
    }
    
    func reverseBinding() -> Binding<Bool> {
        return Binding(get: {
            return self.splitter.config.reverse
        }, set: {
            self.splitter.config.reverse = $0
        })
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
