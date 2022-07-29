//
//  AmbilightManager.swift
//  Ambilight
//
//  Created by Jan de Boer on 08.03.22.
//

import Foundation
import SwiftUI

class AmbilightManager: ObservableObject {
    
    @Environment(\.managedObjectContext) private var viewContext
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Item.timestamp, ascending: true)],
        animation: .default) private var configs: FetchedResults<Grid>
    
    
    var starter: PipelineStarter? = nil
    
    
    var t0 = Date()
    
    
    var lastFinish: Date = Date()
    var measurements: [Double] = []
    @Published var measuredFPS: Int = 0
    
    
}

extension TimeInterval {
    var millisecond: Int {
        Int((self*1000).truncatingRemainder(dividingBy: 1000))
    }
}

extension Sequence where Element: AdditiveArithmetic {
    /// Returns the total sum of all elements in the sequence
    func sum() -> Element { reduce(.zero, +) }
}

extension Collection where Element: BinaryFloatingPoint {
    /// Returns the average of all elements in the array
    func average() -> Element { isEmpty ? .zero : sum() / Element(count) }
}
