//
//  ScreenCapture.swift
//  Ambient Lighting
//
//  Created by Jan de Boer on 28.02.21.
//

import Foundation
import Cocoa

class ScreenCapture: ImageSource {
    
    var description: String = "Screen Capture"
    
    var listener: ImageListener? = nil
    var displayID: CGDirectDisplayID? = nil
    
    func getImage() -> CGImage? {
        getImage(id: nil)
    }
    
    func getImage(id: CGDirectDisplayID? = nil) -> CGImage? {
        let safeID = id ?? displayID ?? CGMainDisplayID()
        return CGDisplayCreateImage(safeID)
    }
    
    func getActiveDisplays() -> [CGDirectDisplayID] {
        let displayCount = getActiveDisplaysCount()
        if displayCount == 0 {
            return []
        }
        return getActiveDisplays(amount: displayCount)
    }
    
    func getActiveDisplaysCount() -> Int {
        var displayCount: UInt32 = 0;
        let result = CGGetActiveDisplayList(0, nil, &displayCount)
        return result != CGError.success ?  0 : Int(displayCount)
    }
    
    func getActiveDisplays(amount : Int) -> [CGDirectDisplayID] {
        var amount32 = UInt32(amount)
        let idMemory = UnsafeMutablePointer<CGDirectDisplayID>.allocate(capacity: amount)
        let result = CGGetActiveDisplayList(amount32, idMemory, &amount32)
        if (result != CGError.success) {
            return []
        }
        let displayIDs = Array(UnsafeBufferPointer(start: idMemory, count: amount))
        idMemory.deallocate()
        return displayIDs
    }
}
