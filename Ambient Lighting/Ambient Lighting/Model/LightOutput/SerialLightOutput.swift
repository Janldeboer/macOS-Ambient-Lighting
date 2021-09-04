//
//  SerialLightOutput.swift
//  Ambient Lighting
//
//  Created by Jan de Boer on 26.03.21.
//

import Foundation
import ORSSerial

struct SerialLightOutput: CorrectedLightOutput {
    
    var controller: SerialController = SerialController()
    var correction: ColorCorrection? = nil
    
    func outputCorrectedColors(colors: [CGColor]) {
        for i in 0 ..< colors.count {
            ledOn(num: i, color: colors[i])
        }
        refreshLEDs()
    }
    
    func ledOn(num: Int, r: Int, g: Int, b: Int) {
        
        if !portOpen() { return }
        
        //print("Setting led \(num) to \(r) \(g) \(b)")
        
        var data: Data
        let text = "led"
        
        data = text.data(using: String.Encoding.utf8)!
        
        var i = UInt8(Double(num))
        var red = UInt8(Double(r))
        var green = UInt8(Double(g))
        var blue = UInt8(Double(b))
        
        data.append(Data(bytes: &i, count: 1))
        data.append(Data(bytes: &red, count: 1))
        data.append(Data(bytes: &green, count: 1))
        data.append(Data(bytes: &blue, count: 1))
        
        controller.serialPort?.send(data)
    }
    
    func ledOn(num: Int, color: CGColor){
        let comp = color.components!
        ledOn(num: num, r: Int(comp[0]*255), g: Int(comp[1]*255), b: Int(comp[2]*255))
    }
    
    func refreshLEDs() {
        if !portOpen() { return }
        _ = controller.sendString(text: "les")
    }
    
    func portOpen() -> Bool {
        if controller.serialPort == nil {
            return false
        } else if controller.serialPort!.isOpen == false {
            return false
        } else {
            return true
        }
    }
}
