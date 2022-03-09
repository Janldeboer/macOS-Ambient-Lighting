//
//  SerialPortViewModel.swift
//  Ambilight
//
//  Created by Jan de Boer on 08.03.22.
//

import Foundation
import ORSSerial

class SerialPortViewModel: ObservableObject {
    @Published var orsport: ORSSerialPort = ORSSerialPortManager.shared().availablePorts[0]
    
    @Published var availablePorts = ORSSerialPortManager.shared().availablePorts
    
    init() {
        orsport = ORSSerialPortManager.shared().availablePorts[0]
        orsport.baudRate = 230400
        print(orsport.isOpen)
    }
    
    func toggleInternalLED() {
        if let data = "lei".data(using: .utf8) {
            print(orsport.send(data))
        }
    }
    
    
    func togglePort() {
        print("Port is \(orsport.isOpen ? "open" : "closed")")
        if orsport.isOpen {
            print("Closing port")
            orsport.close()
        } else {
            orsport.open()
        }
        print("Port is now \(orsport.isOpen ? "open" : "closed")")
    }
    
    func isPortOpen() -> Bool {
        return orsport.isOpen
    }
    
}
