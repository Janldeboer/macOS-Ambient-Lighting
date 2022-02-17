//
//  LightOutputView.swift
//  Ambient Lighting
//
//  Created by Jan de Boer on 04.09.21.
//

import SwiftUI

struct LightOutputView: View {
    @Binding var output: LightOutput?
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 20
            )
                .shadow(radius: 10)
                .foregroundColor(.init(red: 0.3, green: 0.3, blue: 0.3))
            VStack (spacing: 0) {
                
                if let o = output {
                    DisclosureGroup(content: {
                        if let slo = o as? SerialLightOutput {
                            SerialSettingsView(controller: slo.controller)
                                .padding([.top])
                        }
                        
                    }, label: {
                        HStack {
                            Text(o.description)
                                .font(.title)
                                .padding(.leading)
                            Spacer()
                            Image("Delete")
                                .onTapGesture {
                                    output = nil
                                }
                        }
                    })
                        .padding()
                } else {
                    Button("Add Serial Output") {
                        output = SerialLightOutput()
                    }.padding()
                }
            }
        }
    }
}

struct LightOutputView_Previews: PreviewProvider {
    static var previews: some View {
        LightOutputView(output: .constant(SerialLightOutput()))
    }
}
