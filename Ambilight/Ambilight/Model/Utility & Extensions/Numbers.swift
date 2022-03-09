//
//  Numbers.swift
//  Ambilight
//
//  Created by Jan de Boer on 09.03.22.
//

import Foundation

extension Comparable {
    func clamped(to limits: ClosedRange<Self>) -> Self {
        return min(max(self, limits.lowerBound), limits.upperBound)
    }
}
