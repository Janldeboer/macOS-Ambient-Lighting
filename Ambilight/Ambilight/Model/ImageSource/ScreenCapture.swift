//
//  ScreenCapture.swift
//  Ambient Lighting
//
//  Created by Jan de Boer on 28.02.21.
//

import Foundation
import Cocoa

class ScreenCapture {
    var description: String = "Screen Capture"
    var display: CGDirectDisplayID = CGMainDisplayID()
    
    func getActiveDisplays() -> [CGDirectDisplayID] {
        var displayCount: UInt32 = 0;
        var result = CGGetActiveDisplayList(0, nil, &displayCount)
        if (result != CGError.success) {
            print("error: \(result)")
            return []
        }
        let allocated = Int(displayCount)
        let activeDisplays = UnsafeMutablePointer<CGDirectDisplayID>.allocate(capacity: allocated)
        result = CGGetActiveDisplayList(displayCount, activeDisplays, &displayCount)
        
        if (result != CGError.success) {
            print("error: \(result)")
            return []
        }
        
        let displayBuffer: [CGDirectDisplayID] = Array(UnsafeBufferPointer(start: activeDisplays, count: Int(displayCount)))
        
        return displayBuffer
    }
    
    func getImage(id: CGDirectDisplayID? = nil) -> CGImage {
        if getActiveDisplays().contains(id ?? display) {
            return CGDisplayCreateImage(id ?? display)!
        } else {
            return CGDisplayCreateImage(CGMainDisplayID())!
        }
    }
}
