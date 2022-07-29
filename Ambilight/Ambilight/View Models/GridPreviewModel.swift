//
//  GridPreviewModel.swift
//  Ambilight
//
//  Created by Jan de Boer on 09.03.22.
//

import Foundation
import SwiftUI

class GridPreviewModel: ObservableObject {
    
    var splitter: GridSplitter
    var reducer: ScalingReduction?
    
    var rows: Int {
        get {
            return splitter.config.rows
        }
    }
    var columns: Int {
        get {
            return splitter.config.columns
        }
    }
    
    @Published var showIndex: Bool = true
    
    init(splitter: GridSplitter) {
        self.splitter = splitter
    }
    
    func getColor(row: Int, column: Int) -> Color {
        var color = Color.gray
        if splitter.lastSplit != [] {
            let index = splitter.config.getIndex(row: row, column: column)
            if index != -1 {
                color = Color.blue
                if let reducer = reducer {
                    if index < reducer.lastColors.count {
                        color = Color(reducer.lastColors[index])
                    }
                }
            }
        }
        return color
    }
    
    func getText(row: Int, column: Int) -> String {
        let index = splitter.config.getIndex(row: row, column: column)
        return index == -1 ? "" : "\(index)"
    }
    
}
