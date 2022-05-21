//
//  GridSplitter.swift
//  Ambilight
//
//  Created by Jan de Boer on 09.05.22.
//

import Foundation

class GridSplitter: ObservableObject {
    var config: GridSplitterConfig
    
    init () {
        config = GridSplitterConfig(rows: 12, columns: 21, offset: 45, reversed: true)
    }
}

struct GridSplitterConfig {
    var rows: Int
    var columns: Int
    var offset: Int
    var reversed: Bool
}
