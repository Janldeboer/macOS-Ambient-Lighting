//
//  MatrixSplitterExamples.swift
//  Ambient Lighting
//
//  Created by Jan de Boer on 25.03.21.
//

import Foundation

extension Examples {
    
    static func simpleMatrixSplitterConfig() -> MatrixSplitterConfiguration {
        let parts: [Coord] = [ Coord(x: 1, y: 2), Coord(x: 0, y: 2), Coord(x: 0, y: 1), Coord(x: 0, y: 0), Coord(x: 1, y: 0), Coord(x: 2, y: 0), Coord(x: 3, y: 0), Coord(x: 4, y: 0), Coord(x: 4, y: 1), Coord(x: 4, y: 2), Coord(x: 3, y: 2) ]
        return MatrixSplitterConfiguration(numberOfRows: 3, numberOfColumns: 5, requiredParts: parts)
    }
    
    static func simpleMatrixColors() -> [CGColor] {
        return [CGColor](repeating: CGColor(red: 1, green: 0.5, blue: 0, alpha: 1), count: 11)
    }
    
    
    static func  getCoordsBig() -> [Coord] {
        var coords: [Coord] = []
        for x in 12 ... 20 {
            coords.append(Coord(x: x, y: 11))
        }
        for y in 1 ... 10 {
            coords.append(Coord(x: 20, y: 11 - y))
        }
        for x in 0 ... 20 {
            coords.append(Coord(x: 20 - x, y: 0))
        }
        for y in 1 ... 10 {
            coords.append(Coord(x: 0, y: y))
        }
        for x in 0 ... 8 {
            coords.append(Coord(x: x, y: 11))
        }
        return coords
    }
    
    static func getBigMatrixSplitterConfig() -> MatrixSplitterConfiguration {
        return MatrixSplitterConfiguration(numberOfRows: 12, numberOfColumns: 21, requiredParts: getCoordsBig())
    }
}
