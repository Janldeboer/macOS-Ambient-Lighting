//
//  ScalingReduction.swift
//  Ambient Lighting
//
//  Created by Jan de Boer on 25.03.21.
//

import Foundation

class ScalingReduction: ImageReduction {
    var listener: ColorListener? = nil
    
    func handle(splits: [CGImage]) {
        var colors: [CGColor] = []
        for image in splits {
            colors.append(reduceImage(image: image))
        }
        listener?.handleColors(colors)
    }
    
    func reduceImage(image: CGImage) -> CGColor {
        if let scaledImage = image.resize(width: 1, height: 1) {
            if let color = scaledImage.getFirstPixel() {
                return color
            }
        }
        return CGColor(red: 0, green: 0, blue: 0, alpha: 1)
    }
}

extension CGImage {
    
    func resize(width: Int, height: Int) -> CGImage? {
        guard let colorSpace = self.colorSpace else { return nil }
        guard let context = CGContext(data: nil, width: width, height: height, bitsPerComponent: self.bitsPerComponent, bytesPerRow: self.bytesPerRow, space: colorSpace, bitmapInfo: self.bitmapInfo.rawValue) else { return nil }
        
        context.interpolationQuality = .none
        context.draw(self, in: CGRect(x: 0, y: 0, width: width, height: height))
        
        return context.makeImage()
    }
    
    func pixelData(_ debug: Bool = false) -> [UInt8]? {
        var t0 = Date()
        let dataSize = self.width * self.height * 4
        var pixelData = [UInt8](repeating: 0, count: Int(dataSize))
        let colorSpace = CGColorSpaceCreateDeviceRGB()
        let context = CGContext(data: &pixelData,
                                width: Int(self.width),
                                height: Int(self.height),
                                bitsPerComponent: 8,
                                bytesPerRow: 4 * Int(self.width),
                                space: colorSpace,
                                bitmapInfo: CGImageAlphaInfo.noneSkipLast.rawValue)
        if debug { print("context: \(t0.distance(to: Date()).millisecond)") }
        t0 = Date()
        context?.draw(self, in: CGRect(x: 0, y: 0, width: self.width, height: self.height))
        if debug { print("draw: \(t0.distance(to: Date()).millisecond)") }
        t0 = Date()
        return pixelData
    }
    
    func getFirstPixel() -> CGColor? {
        if let pixels = pixelData() {
            let r: CGFloat = CGFloat(pixels[0]) / 255.0
            let g: CGFloat = CGFloat(pixels[1]) / 255.0
            let b: CGFloat = CGFloat(pixels[2]) / 255.0
            let color = CGColor(red: r, green: g, blue: b, alpha: 1.0)
            return color
        }
        return nil
    }
}
