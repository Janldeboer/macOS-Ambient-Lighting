//
//  SerialPortViewModel.swift
//  Ambilight
//
//  Created by Jan de Boer on 08.03.22.
//

import Foundation
import ORSSerial

class SerialPortViewModel: ObservableObject {
    @Published var portName: String = ORSSerialPortManager.shared().availablePorts[0].name {
        didSet {
            print("Should switch port now...")
        }
    }
    
    var orsport: ORSSerialPort = ORSSerialPortManager.shared().availablePorts[0]
    
    var availablePorts: [String] = ORSSerialPortManager.shared().availablePorts.map({$0.name})
    
    init() {
        orsport = ORSSerialPortManager.shared().availablePorts[0]
        
        
        orsport.baudRate = 230400
        orsport.open()
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
