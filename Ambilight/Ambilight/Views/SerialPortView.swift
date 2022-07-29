//
//  SerialPortView.swift
//  Ambilight
//
//  Created by Jan de Boer on 08.03.22.
//

import SwiftUI

struct SerialPortView: View {
    @StateObject var model: SerialPortViewModel = SerialPortViewModel()
    @State var color: Color = .orange {
        didSet {
            print("Check")
        }
    }
    
    var body: some View {
        VStack (alignment: .leading, spacing: 0){
            HStack {
                Picker(selection: $model.orsport, label: Text("Port")) {
                    ForEach(model.availablePorts, id: \.self) { port in
                        Text(port.name).tag(port)
                    }
                }
            }
            HStack {
                Button("Toggle LED") {
                    model.toggleInternalLED()
                }
                ColorPicker("Color", selection: $color)
                Button("Refresh") {
                    // TODO
                    print("B")
                }
                .foregroundColor(color)
                
                Spacer()
                Button(model.isPortOpen() ? "Close Port" : "Open Port") {
                    model.togglePort()
                }
            }.padding(.top)
            Spacer()
        }
    }
}

struct SerialPortView_Previews: PreviewProvider {
    static var previews: some View {
        SerialPortView()
    }
}
