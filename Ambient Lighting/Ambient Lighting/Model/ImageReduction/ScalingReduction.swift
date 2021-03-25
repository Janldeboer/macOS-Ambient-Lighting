//
//  ScalingReduction.swift
//  Ambient Lighting
//
//  Created by Jan de Boer on 25.03.21.
//

import Foundation

struct ScalingReduction: ImageReduction {
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
        
        // draw image to context (resizing it)
        context.interpolationQuality = .none
        context.draw(self, in: CGRect(x: 0, y: 0, width: width, height: height))
        
        // extract resulting image from context
        return context.makeImage()
        
    }
    
    func getFirstPixel() -> CGColor? {
        assert(self.bitsPerPixel == 32, "only support 32 bit images")
        assert(self.bitsPerComponent == 8,  "only support 8 bit per channel")
        guard let imageData = self.dataProvider?.data as Data? else {
            return nil
        }
        let size = self.width * self.height
        let buffer = UnsafeMutableBufferPointer<UInt32>.allocate(capacity: size)
        _ = imageData.copyBytes(to: buffer)
        var result = [CGColor]()
        result.reserveCapacity(size)
        let firstPixel = buffer[0]
        var r : UInt32 = 0
        var g : UInt32 = 0
        var b : UInt32 = 0
        if self.byteOrderInfo == .orderDefault || self.byteOrderInfo == .order32Big {
            r = firstPixel & 255
            g = (firstPixel >> 8) & 255
            b = (firstPixel >> 16) & 255
        } else if self.byteOrderInfo == .order32Little {
            r = (firstPixel >> 16) & 255
            g = (firstPixel >> 8) & 255
            b = firstPixel & 255
        }
        let color = CGColor(red: CGFloat(r) / 255.0, green: CGFloat(g) / 255.0, blue: CGFloat(b) / 255.0, alpha: 1)
        return color
    }
}
