//
//  File.swift
//  Ambient Lighting
//
//  Created by Jan de Boer on 25.03.21.
//

import Foundation

class GridConfiguration: ObservableObject, Equatable {
    @Published var rows: Int = 12
    @Published var columns: Int = 21
    @Published var numberOfParts: Int = 59 {
        didSet {
            if numberOfParts > numberOfPossibleParts {
                numberOfParts = numberOfPossibleParts
            }
            if numberOfParts < 1 {
                numberOfParts = 1
            }
        }
    }
    @Published var startOffset: Int = 43 {
        didSet {
            if startOffset < 0 {
                startOffset = startOffset + numberOfPossibleParts
            }
            if startOffset >= numberOfPossibleParts {
                startOffset = startOffset - numberOfPossibleParts
            }
        }
    }
    var reverse: Bool = true
    var ignoreBlackBars: Bool = false
    
    var numberOfPossibleParts: Int {
        return 2 * (rows + columns) - 4
    }
    
    var parts: [Coord] {
        var parts: [Coord] = []
        var coord = Coord(x: 0, y: 0)
        for _ in 0 ..< startOffset {
            coord = getNextCoord(coord)
        }
        for _ in 0 ..< numberOfParts {
            parts.append(coord)
            coord = getNextCoord(coord)
        }
        if reverse {
            parts = parts.reversed()
        }
        return parts
    }
    
    init() {
    }
    
    init(rows: Int, columns: Int) {
        self.rows = rows
        self.columns = columns
    }
    
    init(rows: Int, columns: Int, start: Int, length: Int, reverse: Bool) {
        self.rows = rows
        self.columns = columns
        self.startOffset = start
        self.numberOfParts = length
        self.reverse = reverse
    }
    
    static func == (lhs: GridConfiguration, rhs: GridConfiguration) -> Bool {
        return lhs.rows == rhs.rows
                && lhs.columns == rhs.columns
                && lhs.startOffset == rhs.startOffset
                && lhs.numberOfParts == rhs.numberOfParts
                && lhs.reverse == rhs.reverse
    }
    
    func getNextCoord(_ coord: Coord) -> Coord {
        if coord.x == 0 {
            if coord.y == 0 {
                // Top left corner
                return Coord(x: coord.x + 1, y: coord.y)
            } else {
                // Left border
                return Coord(x: coord.x, y: coord.y - 1)
            }
        } else if coord.x == columns - 1 {
            if coord.y == rows - 1{
                // Bottom right corner
                return Coord(x: coord.x - 1, y: coord.y)
            } else {
                // Right border
                return Coord(x: coord.x, y: coord.y + 1)
            }
        } else {
            if coord.y == 0 {
                // Top border
                return Coord(x: coord.x + 1, y: coord.y)
            } else {
                // Bottom border
                return Coord(x: coord.x - 1, y: coord.y)
            }
        }
    }
    
}

extension GridConfiguration {
    
    func partExists(row: Int, column: Int) -> Bool {
        return getIndex(row: row, column: column) != -1
    }
    
    
    func getIndex(row: Int, column: Int) -> Int {
        let coord = Coord(x: column, y: row)
        if let i = parts.firstIndex(of: coord) {
            return i
        }
        return -1
    }
}
