//
//  ScreenCaptureSourceView.swift
//  Ambient Lighting
//
//  Created by Jan de Boer on 04.09.21.
//

import SwiftUI

struct ScreenCaptureSourceView: View {
    @Binding var imageSource: ScreenCapture
    
    var timer = Timer.publish(every: 0.2, on: .main, in: .common).autoconnect()
    
    init (imageSource: Binding<ScreenCapture>) {
        self._imageSource = imageSource
    }
    
    @State var images: [CGDirectDisplayID : CGImage] = [:]
    
    var body: some View {
        HStack {
            ForEach(imageSource.getActiveDisplays(), id: \.self) { id in
                VStack(alignment: .center) {
                    ZStack {
                        if let image = images[id] {
                        Image(decorative: image, scale: 10)
                            .onTapGesture {
                                imageSource.display = id
                            }
                        if #available(macOS 12.0, *) {
                            if id == imageSource.display {
                                Rectangle()
                                    .foregroundStyle(.clear)
                                    .border(.green, width: 5)
                                    .frame(width: CGFloat(image.width) / 10, height: CGFloat(image.height) / 10, alignment: .center)
                            }
                        }
                        }
                    }
                    Text("Display \(id)")
                }
            }
        }.onReceive(timer, perform: { _ in
            refreshImages(Timer())
        })
    }
    
    
    func refreshImages(_ timer: Timer) {
        images = [:]
        for id in imageSource.getActiveDisplays() {
            let sc = ScreenCapture(display: id)
            images[id] = sc.getImage()
        }
    }
}


struct ScreenCaptureSourceView_Previes: PreviewProvider {
    static var previews: some View {
        ScreenCaptureSourceView(imageSource: .constant(ScreenCapture()))
    }
}
