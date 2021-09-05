//
//  SerialSettingsView.swift
//  Ambient Lighting
//
//  Created by Jan de Boer on 29.08.21.
//

import SwiftUI
import ORSSerial

struct SerialSettingsView: View {
    
    @Binding var output: SerialLightOutput
    @State var baudRate: Int = 1 {
        didSet {
            output.controller.serialPort?.baudRate = NSNumber(value: baudRate)
        }
    }
    @State var port: String = "none" {
        didSet {
            setPort(path: port)
        }
    }
    
    let controller = SerialController()
    
    
    var body: some View {
        VStack (alignment: .leading, spacing: 0){
            HStack {
                Picker(selection: $output.controller.serialPort, label: Text("Port")) {
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
            Button((output.controller.serialPort?.isOpen ?? false) ? "Close Port" : "Open Port", action: {
                if let port = output.controller.serialPort {
                    port.isOpen ? { _ = port.close() }() : port.open()
                }
            }).padding(.top)
        }
    }
    
    func setPort(path: String) {
        output.controller.selectPort(withPath: path)
    }
}

 struct SettingsView_Previews: PreviewProvider {
     static var previews: some View {
         SerialSettingsView(output: .constant(SerialLightOutput()))
     }
 }
 
