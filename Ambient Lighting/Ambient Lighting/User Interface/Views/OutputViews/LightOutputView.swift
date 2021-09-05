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
                .foregroundColor(.init(red: 0.3, green: 0.3, blue: 0.3))
            VStack (spacing: 0){
                if output == nil {
                    Button("Add Serial Output") {
                        output = SerialLightOutput()
                    }.padding()
                } else {
                    HStack {
                        Spacer()
                        Button("Delete") {
                            output = nil
                        }.padding()
                    }
                    if output is SerialLightOutput {
                        let bind = Binding<SerialLightOutput>(get: { output as! SerialLightOutput}, set: { output = $0})
                        SerialSettingsView(output: bind)
                            .padding([.leading, .trailing, .bottom])
                    }
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
