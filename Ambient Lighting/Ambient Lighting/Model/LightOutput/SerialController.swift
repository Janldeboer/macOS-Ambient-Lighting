//
//  SerialController.swift
//  Ambient Lighting
//
//  Created by Jan de Boer on 08.03.21.
//

import Foundation
import ORSSerial
import SwiftUI
import UniformTypeIdentifiers

class SerialController: NSObject, ORSSerialPortDelegate, ObservableObject {
    @Published var isPortOpen = false
    
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
            isPortOpen = true
            print("Port opened")
        }
    }
    
    func closePort() {
        if let port = self.serialPort {
            if (port.isOpen) {
                port.close()
                isPortOpen = false
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
    
    // MARK: - Actions
    
    func sendString(text input: String) -> Bool {
        let text = input
        if(serialPort?.isOpen == false) {
            openOrClosePort()
            print("Port wasn't open")
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
        isPortOpen = true
    }
    
    func serialPortWasClosed(_ serialPort: ORSSerialPort) {
        print("Port Closed")
        isPortOpen = false
    }
    
    func serialPort(_ serialPort: ORSSerialPort, didReceive data: Data) {
        if let string = NSString(data: data, encoding: String.Encoding.utf8.rawValue) {
            print(string)
        }
    }
    
    func serialPortWasRemovedFromSystem(_ serialPort: ORSSerialPort) {
        self.serialPort = nil
        isPortOpen = false
    }
    
    func serialPort(_ serialPort: ORSSerialPort, didEncounterError error: Error) {
        print("SerialPort \(serialPort) encountered an error: \(error)")
    }
}
