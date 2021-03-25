//
//  ScreenCapture.swift
//  Ambient Lighting
//
//  Created by Jan de Boer on 28.02.21.
//

import Foundation
import Cocoa

struct ScreenCapture: ImageSource {
    
    func getImage() -> CGImage {
        return captureScreen()!
    }
    
    var display: CGDirectDisplayID
    
    init() {
        display = CGMainDisplayID()
    }
    
    func getActiveDisplays() -> [CGDirectDisplayID]? {
        var displayCount: UInt32 = 0;
        var result = CGGetActiveDisplayList(0, nil, &displayCount)
        if (result != CGError.success) {
            print("error: \(result)")
            return nil
        }
        let allocated = Int(displayCount)
        let activeDisplays = UnsafeMutablePointer<CGDirectDisplayID>.allocate(capacity: allocated)
        result = CGGetActiveDisplayList(displayCount, activeDisplays, &displayCount)
        
        if (result != CGError.success) {
            print("error: \(result)")
            return nil
        }
        
        let displayBuffer: [CGDirectDisplayID] = Array(UnsafeBufferPointer(start: activeDisplays, count: Int(displayCount)))
        
        return displayBuffer
    }
    
    func captureScreen() -> CGImage? {
        return CGDisplayCreateImage(display)
    }
}
