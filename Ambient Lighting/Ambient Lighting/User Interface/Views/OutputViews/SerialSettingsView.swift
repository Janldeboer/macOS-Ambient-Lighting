//
//  SerialSettingsView.swift
//  Ambient Lighting
//
//  Created by Jan de Boer on 29.08.21.
//

import SwiftUI
import ORSSerial

struct SerialSettingsView: View {
    
    @StateObject var controller: SerialController
    @State var baudRate: Int = 230400 {
        didSet {
            controller.serialPort?.baudRate = NSNumber(value: baudRate)
        }
    }
    @State var port: String = "none" {
        didSet {
            setPort(path: port)
        }
    }
    
    
    var body: some View {
        VStack (alignment: .leading, spacing: 0){
            HStack {
                Picker(selection: $controller.serialPort, label: Text("Port")) {
                    ForEach(ORSSerialPortManager.shared().availablePorts, id: \.self) { port in
                        Text(port.name).tag(port as ORSSerialPort?)
                    }
                }
                Picker(selection: $baudRate, label:
                        Text("Baud")) {
                    ForEach(controller.availableBaudRates, id: \.self) { baud in
                        Text(String(baud)).tag(NSNumber(value: baud))
                    }
                }
            }
            HStack {
                if controller.isPortOpen {
                    Button("Toggle internal LED") {
                        print(controller.sendString(text: "lei"))
                    }
                }
                Spacer()
                Button(controller.isPortOpen ? "Close Port" : "Open Port") {
                    if let port = controller.serialPort {
                        port.isOpen ? { _ = port.close() }() : port.open()
                    }
                }.padding(.top)
            }
        }
    }
    
    func setPort(path: String) {
        controller.selectPort(withPath: path)
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SerialSettingsView(controller: SerialController())
    }
}

