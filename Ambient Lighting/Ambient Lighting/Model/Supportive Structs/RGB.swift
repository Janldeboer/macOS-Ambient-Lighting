//
//  RGBHSV.swift
//  Ambient Lighting
//
//  Created by Jan de Boer on 17.03.21.
//

import Foundation

struct RGB {
    var red: CGFloat
    var green: CGFloat
    var blue: CGFloat
}

extension RGB {
    init(hsv: HSV) {
        
        let hue = hsv.hue
        
        let diff = hsv.sat * hsv.val
        let minVal = hsv.val - diff
        
        if (hue <= (1/6) || hue > (5/6)) {
            red = hsv.val
            if(hue <= 1/6) {
                blue = minVal
                green = minVal + diff * (hue * 6)
            } else {
                green = minVal
                blue = minVal + diff * (6/6 - hue) * 6
            }
        } else if (hue > (1/6) && hue <= (3/6)) {
            green = hsv.val
            let distance = abs(hue - 2/6)
            if(hue <= 2/6) {
                blue = minVal
                red = minVal + diff * distance * 6
            } else {
                red = minVal
                blue = minVal + diff * distance * 6
            }
        } else if (hue > (3/6) && hue <= (5/6)) {
            blue = hsv.val
            let distance = abs(hue - 4/6)
            if(hue <= 4/6) {
                red = minVal
                green = minVal + diff * distance * 6
            } else {
                green = minVal
                red = minVal + diff * distance * 6
            }
        } else {
            red = 0
            green = 0
            blue = 0
        }
    }
    
    func getCGColor() -> CGColor {
        return CGColor.init(red: self.red, green: self.green, blue: self.blue, alpha: 1)
    }
}
