//
//  AmbientLightingViewModelBindings.swift
//  Ambient Lighting
//
//  Created by Jan de Boer on 04.09.21.
//

import Foundation
import SwiftUI

extension AmbientLightingModel {
    var screenCapture: Binding<ScreenCapture>? {
        if source is ScreenCapture {
            return Binding<ScreenCapture>(get: { self.source as! ScreenCapture }, set: { self.source = $0 })
        } else {
            return nil
        }
    }
    
    var gridSplitConfig: Binding<GridSplitter>? {
        if splitter is GridSplitter {
            return Binding<GridSplitter> (get: { self.splitter as! GridSplitter }, set: { self.splitter = $0 })
        } else {
            return nil
        }
    }
    
    var serialOutput: Binding<SerialLightOutput>? {
        if output is SerialLightOutput {
            return Binding<SerialLightOutput> (get: {self.output as! SerialLightOutput}, set: {self.output = $0})
        } else {
            return nil
        }
    }
}
