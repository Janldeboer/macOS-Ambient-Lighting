//
//  HSV.swift
//  Ambient Lighting
//
//  Created by Jan de Boer on 17.03.21.
//

import Foundation

struct HSV {
    var hue: CGFloat
    var sat: CGFloat
    var val: CGFloat
}

extension HSV {
    init(rgb: RGB) {
        let red = rgb.red
        let green = rgb.green
        let blue = rgb.blue
        
        val = max(red, green, blue)
        if val == 0 {
            hue = 0
            sat = 0
            return
        }
        let minVal = min(red, green, blue)
        let diff = val - minVal
        sat = diff / val // = (val - minVal) / val = 1 - minVal / val
        /*
         sat = 1 - minVal / val
         minVal / val = 1 - sat
         minVal = val - val * sat
         */
        if (diff == 0) {
            hue = 0
            return
        }
        if(red == val) {
            let base: CGFloat = 0
            if (green == minVal) {
                hue = base - (1.0/6) * (blue - minVal) / diff
            } else {
                hue = base + (1.0/6) * (green - minVal) / diff
            }
        } else if (green == val) {
            let base: CGFloat = 1/3
            if (blue == minVal) {
                hue = base - (1.0/6) * (red - minVal) / diff
            } else {
                hue = base + (1.0/6) * (blue - minVal) / diff
            }
        } else if (blue == val) {
            let base: CGFloat = 2/3
            if (red == minVal) {
                hue = base - (1.0/6) * (green - minVal) / diff
            } else {
                hue = base + (1.0/6) * (red - minVal) / diff
            }
        } else {
            hue = 0
        }
        if(hue < 0) {
            hue = hue + 1
        }
        if(hue > 1) {
            hue = hue - 1
        }
    }
    
    func getCGColor() -> CGColor {
        return RGB(hsv: self).getCGColor()
    }
}

