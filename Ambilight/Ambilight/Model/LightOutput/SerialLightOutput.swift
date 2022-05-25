//
//  SerialLightOutput.swift
//  Ambient Lighting
//
//  Created by Jan de Boer on 26.03.21.
//

import Foundation
import ORSSerial

class SerialLightOutput: LightOutput, ObservableObject {
    
    var description: String = "Serial Output"
    
    @Published var port: ORSSerialPort? = ORSSerialPortManager.shared().availablePorts[0]
    
    func outputColors(colors: [CGColor]) {
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
        
        port?.send(data)
    }
    
    func ledOn(num: Int, color: CGColor){
        let comp = color.components!
        if comp.count >= 3 {
            ledOn(num: num, r: Int(comp[0]*255), g: Int(comp[1]*255), b: Int(comp[2]*255))
        }
    }
    
    func refreshLEDs() {
        if !portOpen() { return }
        if let data = "les".data(using: .utf8) {
            port?.send(data)
        }
    }
    
    func portOpen() -> Bool {
        if port == nil {
            return false
        } else if port!.isOpen == false {
            return false
        } else {
            return true
        }
    }
    
}
