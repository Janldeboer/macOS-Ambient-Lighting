//
//  ImageSourceView.swift
//  Ambient Lighting
//
//  Created by Jan de Boer on 02.09.21.
//

import SwiftUI

struct ImageSourceView: View {
    @Binding var imageSource: ImageSource?
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 20
            )
                .shadow(radius: 10)
                .foregroundColor(.init(red: 0.3, green: 0.3, blue: 0.3))
            VStack (spacing: 0) {
                if imageSource == nil {
                    Button("Add ScreenCapture as image Source") {
                        imageSource = ScreenCapture()
                    }.padding()
                } else {
                    HStack {
                        Text(imageSource!.description)
                            .font(.title)
                            .padding()
                        Spacer()
                        Image("Delete")
                            .onTapGesture {
                                imageSource = nil
                            }
                            .padding()
                    }
                    if imageSource is ScreenCapture {
                        
                        let bind = Binding<ScreenCapture>(get: { imageSource as! ScreenCapture}, set: { imageSource = $0})
                        ScreenCaptureSourceView(imageSource: bind)
                            .padding([.leading, .trailing, .bottom])
                    }
                }
            }
        }
    }
}


struct ImageSourceView_Previews: PreviewProvider {
    static var previews: some View {
        ImageSourceView(imageSource: .constant(ScreenCapture()))
    }
}
