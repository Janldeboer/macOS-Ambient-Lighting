//
//  SerialOutput.swift
//  Ambient Lighting
//
//  Created by Jan de Boer on 08.03.21.
//

import Foundation
import ORSSerial
import SwiftUI



class SerialOutput: NSObject, ORSSerialPortDelegate, AmbilightOutput {
    
    
    @objc let serialPortManager = ORSSerialPortManager.shared()
    @objc let availableBaudRates = [300, 1200, 2400, 4800, 9600, 14400, 19200, 28800, 38400, 57600, 115200, 230400]
    
    @objc dynamic var serialPort: ORSSerialPort? {
        didSet {
            oldValue?.close()
            oldValue?.delegate = nil
            serialPort?.delegate = self
        }
    }
    
    func selectPort(withPath path: String) {
        for port in serialPortManager.availablePorts {
            if port.path == path {
                serialPort = port
                print("Port set to \(port.name)")
            }
        }
    }
    
    func openPort() {
        if let port = self.serialPort {
            port.open()
            print("Port opened")
        }
    }
    
    func closePort() {
        if let port = self.serialPort {
            if (port.isOpen) {
                port.close()
            }
        }
    }
    
    func setBaudRate(baudRate: Int) {
        if availableBaudRates.contains(baudRate) {
            serialPort?.baudRate = NSNumber(value: baudRate)
        }
    }
    
    override init() {
        super.init()
    }
    
    // MARK: - LED Controlling
    
    func ledOn(num: Int, r: Int, g: Int, b: Int) {
        print("Setting led \(num) to \(r) \(g) \(b)")
        
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
        
        self.serialPort?.send(data)
    }
    
    func outputColors(colors: [CGColor]) {
        for i in 0 ..< colors.count {
            ledOn(num: i, color: colors[i])
        }
        refreshLEDs()
    }
    
    func ledOn(num: Int, color: CGColor){
        let comp = color.components!
        ledOn(num: num, r: Int(comp[0]*255), g: Int(comp[1]*255), b: Int(comp[2]*255))
    }
    
    func refreshLEDs() {
        sendString(text: "les")
    }
    
    // MARK: - Actions
    
    func sendString(text input: String) -> Bool {
        let text = input
        if(serialPort?.isOpen == false) {
            openOrClosePort()
            print("Port wasn't opened")
        }
        if let data = text.data(using: String.Encoding.utf8) {
            return self.serialPort?.send(data) ?? false
        }
        return false
    }
    
    func openOrClosePort() {
        if let port = self.serialPort {
            if (port.isOpen) {
                closePort()
            } else {
                openPort()
            }
        }
    }
    
    // MARK: - ORSSerialPortDelegate
    
    func serialPortWasOpened(_ serialPort: ORSSerialPort) {
        print("Port Opened")
    }
    
    func serialPortWasClosed(_ serialPort: ORSSerialPort) {
        print("Port Closed")
    }
    
    func serialPort(_ serialPort: ORSSerialPort, didReceive data: Data) {
        
    }
    
    func serialPortWasRemovedFromSystem(_ serialPort: ORSSerialPort) {
        self.serialPort = nil
    }
    
    func serialPort(_ serialPort: ORSSerialPort, didEncounterError error: Error) {
        print("SerialPort \(serialPort) encountered an error: \(error)")
    }
}
